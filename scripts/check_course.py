#!/usr/bin/env python3
"""Checks every task in the course, the way a student's IDE would.

Two assertions per exercise, and the second is the one worth having:

  solved    the file as committed must compile and its test must pass
  unsolved  with the placeholder substituted in, the test must FAIL

The second catches the mistake that is otherwise invisible: a placeholder whose span does not
actually remove the answer. Such a task looks fine in every screenshot, passes the solved check,
and hands the student a completed exercise. Nothing else finds it.

Theory tasks are compiled but not run — they exist to be read and to have a Run button that works,
and many of them print things no test should be asserting on.

Run from the course root:

    scripts/check_course.py            # everything
    scripts/check_course.py --solved   # skip the unsolved half, which is the slow one
"""
from __future__ import annotations

import argparse
import re
import subprocess
import sys
from dataclasses import dataclass, field
from pathlib import Path

# Deliberately not PyYAML: the course has to be checkable on a clean machine with nothing but
# Python and a GNAT toolchain, and these files are ours -- written by script, in one shape. If the
# YAML ever grows past what this reads, that is the moment to take the dependency.
TYPE = re.compile(r"^type:\s*(\S+)", re.M)
FILE_ENTRY = re.compile(r"^\s*-\s*name:\s*(\S+)\s*$", re.M)
OFFSET = re.compile(r"^(?P<indent> *)-\s*offset:\s*(?P<offset>\d+)\s*$")
LENGTH = re.compile(r"^\s*length:\s*(?P<length>\d+)\s*$")
BLOCK_TEXT = re.compile(r"^(?P<indent> *)placeholder_text:\s*\|(?P<explicit>\d*)-?\s*$")
QUOTED_TEXT = re.compile(r'^\s*placeholder_text:\s*"(?P<body>(?:[^"\\]|\\.)*)"\s*$')
ANY_TEXT = re.compile(r"^\s*placeholder_text:")

# Placeholder text that must keep its leading whitespace has to be a quoted scalar, not a block
# scalar. A block scalar strips the indentation common to its lines, so indenting the content of
# one changes precisely nothing -- confirmed against a real YAML parser, where the indented and
# unindented forms produce identical strings. An explicit indicator (`|2-`) does work, but counts
# from the parent node's column, so reindenting the file silently changes the student's code.

# A block scalar ends at the first line indented no further than its key -- it is NOT "every
# following indented line", which is what a regex reaches for and gets wrong. The bug that taught
# this: a greedy pattern swallowed the `- name: tests/...` entry that follows, so the substituted
# file contained stray YAML, failed to *compile*, and the "must fail unsolved" assertion passed for
# entirely the wrong reason. A checker that can pass for the wrong reason is worse than none.


@dataclass
class Placeholder:
    offset: int
    length: int
    text: str


@dataclass
class Task:
    directory: Path
    kind: str
    sources: list[Path] = field(default_factory=list)
    tests: list[Path] = field(default_factory=list)
    placeholders: dict[Path, list[Placeholder]] = field(default_factory=dict)

    @property
    def name(self) -> str:
        try:
            return str(self.directory.relative_to(Path.cwd()))
        except ValueError:
            return str(self.directory)


def read_placeholders(lines: list[str], start: int, stop: int) -> list[Placeholder]:
    """Read every placeholder between two line indices, honouring YAML block-scalar scoping.

    A note on how `placeholder_text` is written, kept here because `task-info.yaml` cannot keep it.
    The text is indented Ada and the indentation is load-bearing -- it is the student's first sight
    of the exercise. A bare `|-` block scalar strips the indentation common to its lines and would
    flatten it. Two forms survive: a quoted scalar with `\\n`, and a block scalar with an explicit
    indentation indicator (`|2-`), which is what the IDE writes.

    The IDE is why this note is here rather than beside what it describes. Opening the course in
    the JetBrains Academy editor rewrites these files -- quoted scalars become `|2-` blocks -- and
    strips any comment it passes on the way. The explanation was lost every time the course was
    opened, so it lives in the checker, which the editor never touches.

    Nothing rests on remembering it. A flattened or misplaced placeholder makes the unsolved
    exercise stop compiling, or stop failing, and the two assertions per exercise catch that.
    """
    placeholders: list[Placeholder] = []
    index = start
    while index < stop:
        offset_match = OFFSET.match(lines[index])
        if not offset_match:
            index += 1
            continue

        offset = int(offset_match.group("offset"))
        length: int | None = None
        text: str | None = None
        index += 1

        while index < stop:
            line = lines[index]

            # Comments and blank lines sit between these keys quite legally, and a line-oriented
            # scan that treats one as "end of this placeholder" stops before reading the text.
            # That happened: a comment added above placeholder_text made this report a task with
            # no placeholder at all, which it then declined to verify while still printing ok.
            if not line.strip() or line.lstrip().startswith("#"):
                index += 1
                continue

            length_match = LENGTH.match(line)
            if length_match:
                length = int(length_match.group("length"))
                index += 1
                continue

            quoted_match = QUOTED_TEXT.match(line)
            if quoted_match:
                text = (
                    quoted_match.group("body")
                    .replace("\\n", "\n")
                    .replace('\\"', '"')
                    .replace("\\\\", "\\")
                )
                index += 1
                continue

            block_match = BLOCK_TEXT.match(line)
            if not block_match:
                # Refuse to walk past a placeholder_text written in a form not handled here.
                # Silently skipping one costs the whole "must fail unsolved" assertion for that
                # task -- it would report ok having checked nothing, which is the one outcome
                # worse than reporting a failure.
                if ANY_TEXT.match(line):
                    raise SystemExit(
                        f"check_course.py cannot read this placeholder_text, so it cannot verify "
                        f"the task:\n  {line}\nUse a double-quoted scalar or a |- block."
                    )
                break

            # The block runs until a line indented no further than its key. Blank lines belong to
            # the block regardless -- they carry no indentation to judge by.
            key_indent = len(block_match.group("indent"))
            index += 1
            body: list[str] = []
            while index < stop:
                candidate = lines[index]
                if candidate.strip() and (len(candidate) - len(candidate.lstrip())) <= key_indent:
                    break
                body.append(candidate)
                index += 1

            while body and not body[-1].strip():
                body.pop()

            # An explicit indentation indicator (`|2-`) counts from the key's own column, and it
            # is how JetBrains Academy writes any placeholder whose text is indented -- opening
            # the course rewrites every one of these into that form. Without honouring it, the
            # leading whitespace is stripped here and nowhere else, so this script would test a
            # different stub than the student is given. With no indicator, YAML takes the base
            # from the least-indented line, which is what min() reproduces.
            explicit = block_match.group("explicit")
            if explicit:
                base = key_indent + int(explicit)
            else:
                base = min((len(l) - len(l.lstrip()) for l in body if l.strip()), default=0)
            text = "\n".join(l[base:] for l in body)

        # A placeholder this parser could not fully read must not be quietly dropped. Dropping one
        # removes the "must fail unsolved" assertion for its task, and the task then reports ok
        # having proved nothing -- the exact shape of every silent-pass bug this script has had.
        if length is not None and text is None:
            raise SystemExit(
                f"placeholder at offset {offset} has no placeholder_text this parser could read, "
                f"so the task cannot be verified. Give it a double-quoted scalar or a |- block."
            )
        if length is not None:
            placeholders.append(Placeholder(offset, length, text))
    return placeholders


def read_task(info: Path) -> Task:
    text = info.read_text(encoding="utf-8")
    lines = text.split("\n")
    kind = TYPE.search(text)
    task = Task(directory=info.parent, kind=kind.group(1) if kind else "unknown")

    entries = [i for i, line in enumerate(lines) if FILE_ENTRY.match(line)]
    for position, line_index in enumerate(entries):
        relative = FILE_ENTRY.match(lines[line_index]).group(1)
        path = task.directory / relative
        (task.tests if relative.startswith("tests/") else task.sources).append(path)

        # Placeholders belong to the file entry above them, so scope the scan to the lines between
        # this entry and the next.
        stop = entries[position + 1] if position + 1 < len(entries) else len(lines)
        found = read_placeholders(lines, line_index + 1, stop)
        if found:
            task.placeholders[path] = found
    return task


def build_and_run(main: Path, root: Path, force: bool = False) -> tuple[int, str, bool]:
    """gprbuild one main, then run it.

    Returns (exit code, combined output, built) — `built` distinguishing "the test ran and failed"
    from "it never compiled". Both are non-zero, and conflating them is how a checker reports a
    green exercise that is actually broken.

    `force` passes -f, and every exercise build sets it. This script edits sources in place --
    stub in, original back -- and gprbuild decides what to recompile by comparing timestamps at
    one-second resolution, so two writes a fraction of a second apart can leave it holding an
    object it believes is current. When that happens the *next* run tests the previous build: a
    correct, committed solution failing with empty output because bin/ still held the stub.

    Deleting the derived files by hand was tried first and cannot be relied on. What actually
    cleared the state was rm -rf on the whole object directory, which means the reasoning about
    precisely which artefacts go stale was incomplete -- and a fix that rests on incomplete
    reasoning about someone else's staleness rules is not a fix. This does not depend on them at
    all. The price is recompiling a two-file harness once per exercise; the alternative is a
    verdict that turns on sub-second timing, which is worse than having no checker.
    """
    build = subprocess.run(
        ["gprbuild", "-p", "-P", "course.gpr", main.name]
        + (["-f"] if force else [])
        + ["-cargs:Ada", "-gnatef"],
        cwd=root, capture_output=True, text=True,
    )
    if build.returncode != 0:
        return build.returncode, build.stdout + build.stderr, False

    executable = root / "bin" / main.stem
    if not executable.exists():
        return 1, f"{executable} was not produced", False
    run = subprocess.run([str(executable)], cwd=root, capture_output=True, text=True)
    return run.returncode, run.stdout + run.stderr, True


def invalidate(path: Path, root: Path) -> None:
    """Delete what gprbuild derived from this source, so the next build cannot skip it.

    gprbuild decides staleness by comparing timestamps at one-second resolution. This script
    rewrites a source twice in quick succession -- stub in, original back -- and both writes can
    land in the same second as the object built between them, at which point gprbuild says "up to
    date" and the *next* run silently tests the previous build.

    That is not theoretical. It produced a committed, correct solution failing its own check with
    empty output, because bin/ still held the binary built from the stub. The failure is worse than
    it looks: the same race can leave a stub check running the solved binary, and the direction it
    falls depends on which write happened to cross a second boundary. A checker whose verdict turns
    on that is not a checker.
    """
    for derived in (root / "obj" / f"{path.stem}.o",
                    root / "obj" / f"{path.stem}.ali",
                    root / "bin" / path.stem):
        derived.unlink(missing_ok=True)


def substitute(path: Path, placeholders: list[Placeholder], root: Path) -> str:
    """Replace each placeholder span with its text. Returns the original, for restoring."""
    original = path.read_text(encoding="utf-8")
    text = original
    for placeholder in sorted(placeholders, key=lambda p: p.offset, reverse=True):
        text = (
            text[: placeholder.offset]
            + placeholder.text
            + text[placeholder.offset + placeholder.length:]
        )
    path.write_text(text, encoding="utf-8")
    invalidate(path, root)
    return original


def content_list(info: Path) -> list[str] | None:
    """The `content:` sequence of a course/section/lesson file, or None if it has none."""
    if not info.is_file():
        return None
    items: list[str] = []
    seen = False
    for line in info.read_text(encoding="utf-8").split("\n"):
        if re.match(r"^content:\s*$", line):
            seen = True
            continue
        if seen:
            entry = re.match(r"^\s+-\s*(.+?)\s*$", line)
            if entry:
                items.append(entry.group(1).strip("\"'"))
            elif line.strip():
                break
    return items if seen else None


def declares_main(source: Path) -> bool:
    """Whether this file is a runnable program, by Ada's rule for one.

    A main is a parameterless library-level subprogram, and GNAT names the unit after its file.
    The IDE's Run button uses exactly this rule, which is why it has to be checked here: a file
    that satisfies it but is missing from `for Main use` gets a button that fails, and a file that
    does not satisfy it can never be run however it is declared.
    """
    unit = source.stem
    for line in source.read_text(encoding="utf-8").split("\n"):
        stripped = line.strip()
        if stripped.startswith("--"):
            continue
        match = re.match(rf"(procedure|function)\s+{re.escape(unit)}\b(.*)", stripped, re.I)
        if match:
            return not match.group(2).lstrip().startswith("(")
    return False


def check_mains(root: Path) -> list[str]:
    """`for Main use` must name every task source that is a runnable program, and only those."""
    gpr = (root / "course.gpr").read_text(encoding="utf-8")
    block = re.search(r"for\s+Main\s+use\s*(.*?);", gpr, re.S | re.I)
    listed = set(re.findall(r'"([^"]+)"', block.group(1))) if block else set()

    problems: list[str] = []
    runnable = set()
    for source in sorted(root.glob("*/*/*/src/*.adb")):
        if declares_main(source):
            runnable.add(source.name)
            if source.name not in listed:
                problems.append(
                    f"{source.name} is a runnable program but course.gpr does not list it in "
                    f"`for Main use`, so its Run button will fail with no executable to run"
                )
    for name in sorted(listed - runnable):
        if not (root / "harness" / name).is_file():
            problems.append(
                f"course.gpr lists {name} as a main, but no task source of that name is a "
                f"parameterless subprogram -- gprbuild will refuse the project"
            )
    return problems


def check_unit_names(root: Path) -> list[str]:
    """A task's unit is its directory name, spaces to underscores, and its file is that lowercased.

    This exists in place of a prefix. Exercises used to be named `Imp_Hello_Greet` --
    section, lesson, task -- because the whole course is one GNAT project, so every library-level
    unit shares one namespace and two tasks called `Greet` would collide. That bought safety at the
    cost of teaching beginners, by example on page one, a naming style no Ada programmer uses.

    The names are canonical now, and the collision the prefix prevented is caught here instead: a
    duplicate is a named failure while the author is looking at it, rather than something a mangled
    name quietly made impossible forever. Deriving the expected name rather than merely checking
    for duplicates also catches the likelier mistake -- a file renamed without its unit, or a task
    directory renamed without either.

    Reported both ways round, as `check_structure` does, because a unit that disagrees with its
    file fails at compile time and loudly, while a unit that disagrees with its directory does not
    fail at all -- it just leaves the student opening `classify.adb` from a task called something
    else.
    """
    problems: list[str] = []
    seen: dict[str, Path] = {}
    for source in sorted(root.glob("*/*/*/src/*.adb")):
        expected = source.parent.parent.name.replace(" ", "_")
        unit = source.stem

        if unit.lower() != expected.lower():
            problems.append(
                f"{source.name} sits in the task '{source.parent.parent.name}', so its unit should "
                f"be {expected} in {expected.lower()}.adb -- a student opening this task gets a "
                f"file named after something else"
            )
        if unit.lower() in seen:
            # By task, not by file name: a collision means the file names are identical, so
            # printing those twice says nothing about where either of them is.
            here = source.parent.parent
            there = seen[unit.lower()].parent.parent
            problems.append(
                f"'{here.parent.name}/{here.name}' and '{there.parent.name}/{there.name}' are both "
                f"unit {unit} -- the course is one GNAT project, so they share a namespace and "
                f"gprbuild will refuse it. Rename one of the tasks"
            )
        seen[unit.lower()] = source

    if not seen:
        problems.append("no task sources found at all, so this check proves nothing")
    return problems


def check_structure(root: Path) -> list[str]:
    """Every directory listed must exist, and every directory present must be listed.

    Both directions, because they fail differently and both fail quietly. A name with no directory
    stops JetBrains Academy loading the course. A directory with no name is worse: the task is
    simply absent from the course the student sees, while this script -- which finds tasks by
    globbing -- checks it and reports ok. That is a task that passes every check and does not
    exist.
    """
    problems: list[str] = []
    levels = [
        (root / "course-info.yaml", "course", "section"),
        *[(p / "section-info.yaml", "section", "lesson") for p in root.glob("*/section-info.yaml")
          for p in [p.parent]],
        *[(p / "lesson-info.yaml", "lesson", "task") for p in root.glob("*/*/lesson-info.yaml")
          for p in [p.parent]],
    ]
    for info, kind, child in levels:
        listed = content_list(info)
        if listed is None:
            problems.append(f"{info.parent.name}/{info.name}: no content: list")
            continue
        parent = info.parent
        present = sorted(
            d.name for d in parent.iterdir()
            if d.is_dir() and not d.name.startswith(".") and d.name not in {
                "src", "tests", "obj", "bin", "harness", "scripts"
            }
        )
        for name in listed:
            if not (parent / name).is_dir():
                problems.append(
                    f"{info.name} in {parent.name or '.'} lists {child} '{name}', "
                    f"but no such directory exists -- the course will not load"
                )
        for name in present:
            if name not in listed:
                problems.append(
                    f"{parent.name or '.'}/{name} is a {child} directory that {info.name} does "
                    f"not list -- students will never see it, and this script would still check it"
                )
    return problems


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--solved", action="store_true", help="skip the unsolved half")
    args = parser.parse_args()

    root = Path.cwd()
    if not (root / "course.gpr").is_file():
        print("run this from the course root", file=sys.stderr)
        return 2

    structure = check_structure(root) + check_mains(root) + check_unit_names(root)
    if structure:
        for problem in structure:
            print(f"  STRUCTURE  {problem}", file=sys.stderr)
        return 1
    print("  ok       structure: content lists match directories, `for Main use` matches the\n"
          "           sources that are runnable programs, and every unit is named for its task")

    failures: list[str] = []
    tasks = [read_task(p) for p in sorted(root.glob("*/*/*/task-info.yaml"))]
    if not tasks:
        print("no tasks found", file=sys.stderr)
        return 2

    for task in tasks:
        if task.kind == "theory":
            for source in task.sources:
                code, output, _ = build_and_run(source, root)
                # Theory examples are compiled, not judged: several of AdaCore's illustrate a
                # runtime failure on purpose. A compile error is still a real defect.
                if "error:" in output:
                    failures.append(f"{task.name}: theory example does not compile\n{output}")
                else:
                    print(f"  ok       {task.name} ({source.name})")
            continue

        for test in task.tests:
            # force=True: this is the check that was reading a binary left over from the previous
            # run's unsolved pass, and reporting a correct solution as broken.
            code, output, _ = build_and_run(test, root, force=True)
            if code != 0:
                failures.append(f"{task.name}: the committed solution does not pass\n{output}")
                continue
            print(f"  ok       {task.name} (solved)")

            if args.solved or not task.placeholders:
                continue

            originals = {p: substitute(p, phs, root) for p, phs in task.placeholders.items()}
            try:
                code, output, built = build_and_run(test, root, force=True)
                if code == 0:
                    failures.append(
                        f"{task.name}: PASSES UNSOLVED -- the placeholder does not remove the "
                        f"answer, so the exercise is already done for the student"
                    )
                elif not built:
                    # It failed, but for the wrong reason. The student is meant to be told their
                    # answer is wrong, not handed a file that will not compile before they have
                    # touched it -- and a checker that accepts this cannot tell a good exercise
                    # from a placeholder that leaves broken syntax behind.
                    failures.append(
                        f"{task.name}: the unsolved exercise DOES NOT COMPILE. The starting state "
                        f"a student is given must build; only the test should fail.\n{output}"
                    )
                else:
                    print(f"  ok       {task.name} (compiles unsolved, and fails, as it must)")
            finally:
                for path, text in originals.items():
                    path.write_text(text, encoding="utf-8")
                    # Same reason as in substitute(): the restore must not leave the stub's
                    # object file looking current, or the next run checks the wrong binary.
                    invalidate(path, root)

    print()
    if failures:
        for failure in failures:
            print(f"FAIL  {failure}\n")
        print(f"{len(failures)} problem(s)")
        return 1
    print(f"all {len(tasks)} task(s) good")
    return 0


if __name__ == "__main__":
    sys.exit(main())
