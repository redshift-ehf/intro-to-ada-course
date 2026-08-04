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
    scripts/check_course.py --clean    # ... from an empty obj/ and bin/, which is the honest one
    scripts/check_course.py --solved   # skip the unsolved half, which is the slow one
"""
from __future__ import annotations

import argparse
import re
import shutil
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
QUOTED_START = re.compile(r'^\s*placeholder_text:\s*"(?P<rest>.*)$')
SINGLE_START = re.compile(r"^\s*placeholder_text:\s*'(?P<rest>.*)$")
ANY_TEXT = re.compile(r"^\s*placeholder_text:")


def close_single(body: str) -> int | None:
    """Where a single-quoted scalar ends, or None if it does not end in this text.

    A single-quoted scalar's only escape is `''` for one quote, so finding the end means stepping
    over those pairs rather than stopping at the first quote it meets.
    """
    index = 0
    while index < len(body):
        if body[index] != "'":
            index += 1
        elif index + 1 < len(body) and body[index + 1] == "'":
            index += 2
        else:
            return index
    return None


def closes_quote(body: str) -> bool:
    """Whether this text ends the double-quoted scalar it began.

    A final `"` preceded by an odd number of backslashes is escaped and does not close anything.
    """
    if not body.endswith('"'):
        return False
    without_quote = body[:-1]
    trailing_backslashes = len(without_quote) - len(without_quote.rstrip("\\"))
    return trailing_backslashes % 2 == 0


def unescape(body: str) -> str:
    """The escapes YAML double-quoted scalars use, in one pass.

    One pass rather than a chain of str.replace calls, because that chain is order-dependent and
    wrong: replacing \\\\n before \\\\\\\\ turns a literal backslash followed by n into a newline.
    Nothing in the course has hit that yet, which is exactly why it should not be left waiting.
    """
    out: list[str] = []
    index = 0
    while index < len(body):
        if body[index] != "\\" or index + 1 >= len(body):
            out.append(body[index])
            index += 1
            continue
        escape = body[index + 1]
        if escape not in ESCAPES:
            raise SystemExit(
                f"check_course.py does not know the escape \\{escape} in this placeholder_text, "
                f"so it cannot reproduce the stub a student is given:\n  {body}"
            )
        out.append(ESCAPES[escape])
        index += 2
    return "".join(out)


ESCAPES = {"n": "\n", "t": "\t", '"': '"', "\\": "\\", " ": " ", "0": "\0"}

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

            quoted_match = QUOTED_START.match(line)
            if quoted_match:
                # A double-quoted scalar, which the IDE may have folded across several lines.
                # It writes a trailing `\` to escape the line break and indents what follows;
                # YAML then strips that indentation, and a leading `\ ` puts back a space that
                # would otherwise be lost to it. Reassembled here rather than rejected, because
                # the IDE folds any placeholder text past its wrap width and the alternative is
                # a course that cannot use a long one-line stub.
                body = quoted_match.group("rest")
                while not closes_quote(body):
                    if not body.endswith("\\") or index + 1 >= stop:
                        raise SystemExit(
                            f"check_course.py cannot find the end of this placeholder_text, so "
                            f"it cannot verify the task:\n  {line}"
                        )
                    index += 1
                    body = body[:-1] + lines[index].lstrip()
                text = unescape(body[:-1])
                index += 1
                continue

            single_match = SINGLE_START.match(line)
            if single_match:
                # A single-quoted scalar, which is what the IDE writes when the text contains a
                # double quote -- quoting it the other way is cheaper than escaping. Nothing
                # inside is an escape except `''`, so no unescaping runs here beyond that.
                body = single_match.group("rest")
                end = close_single(body)
                while end is None:
                    if index + 1 >= stop:
                        raise SystemExit(
                            f"check_course.py cannot find the end of this placeholder_text, so "
                            f"it cannot verify the task:\n  {line}"
                        )
                    index += 1
                    # A line break inside a single-quoted scalar folds to one space.
                    body = body + " " + lines[index].strip()
                    end = close_single(body)
                text = body[:end].replace("''", "'")
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


def decoded(completed: subprocess.CompletedProcess) -> str:
    """subprocess output as text, without letting a bad byte kill the run.

    errors="replace" rather than text=True, because a test program is not obliged to print valid
    UTF-8 and a *wrong* one very often does not. An unsolved exercise that returns an uninitialised
    String prints whatever was in that memory, and strict decoding then raises UnicodeDecodeError
    out of subprocess -- killing the checker rather than failing the task. That is exactly
    backwards: garbage output is the strongest possible evidence that an exercise is unsolved, and
    it must be reportable.
    """
    return (completed.stdout.decode("utf-8", errors="replace")
            + completed.stderr.decode("utf-8", errors="replace"))


def compiles(source: Path, root: Path) -> tuple[bool, str]:
    """Compile one source and say whether the compiler was happy. Nothing is bound, linked or run.

    `-c` is what makes this usable, and it is the whole point. A theory task is often a package
    rather than a main -- Show Child Privacy is four of them -- and a full `gprbuild` on a package
    compiles it and then fails at the *bind* step with "cannot be used as a main program". That is
    not a defect in the example; it is gprbuild answering a question nobody asked.

    Asking the other way was worse. The check used to grep the combined output for `error:`, which
    reads the compiler's diagnostics when the build fails and the *program's stdout* when it
    succeeds. So a theory example that compiled, ran, and printed the word `error:` was reported as
    "does not compile" -- and one that was a package printed a bind diagnostic containing no
    `error:` and was reported ok. Both answers happened to come out right in this course, the first
    by one character of case in show_predefined_exceptions.adb, which prints `Constraint_Error:`.

    Compiling and reading the exit status answers the question that was actually being asked, and
    it does not depend on what anything printed.
    """
    build = subprocess.run(
        ["gprbuild", "-c", "-p", "-P", "course.gpr", source.name, "-cargs:Ada", "-gnatef"],
        cwd=root, capture_output=True,
    )
    return build.returncode == 0, decoded(build)


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

    Output is decoded by `decoded`, for the reason given there.
    """
    build = subprocess.run(
        ["gprbuild", "-p", "-P", "course.gpr", main.name]
        + (["-f"] if force else [])
        + ["-cargs:Ada", "-gnatef"],
        cwd=root, capture_output=True,
    )
    if build.returncode != 0:
        return build.returncode, decoded(build), False

    executable = root / "bin" / main.stem
    if not executable.exists():
        return 1, f"{executable} was not produced", False
    run = subprocess.run([str(executable)], cwd=root, capture_output=True)
    return run.returncode, decoded(run), True


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


def check_source_dirs(root: Path) -> list[str]:
    """Every section in `content:` must have a `Source_Dirs` entry in course.gpr.

    `Source_Dirs` is maintained by hand, one `"<Section>/**"` per section, and until now nothing
    checked it -- `check_mains` reads course.gpr but only for `for Main use`. A section added to
    `course-info.yaml` and forgotten here is not a structural failure and does not say what it is:
    gprbuild simply cannot see the files, so every task in the chapter fails to build with a
    complaint about a source that is plainly sitting there. Twenty-two chapters in, that is a bad
    afternoon waiting to happen; the answer costs eight lines.

    Only this direction. The reverse -- an entry with no section -- gprbuild already rejects
    outright, because it refuses a project naming a directory that does not exist, which is the
    property `course.gpr`'s own comment relies on to keep the list from drifting ahead of the
    course.
    """
    gpr = (root / "course.gpr").read_text(encoding="utf-8")
    block = re.search(r"for\s+Source_Dirs\s+use\s*(.*?);", gpr, re.S | re.I)
    if not block:
        return ["course.gpr has no `for Source_Dirs use` -- gprbuild will find no sources at all"]

    #  Entries are "<Section>/**"; compare on the section name, not the glob.
    listed = {entry.split("/", 1)[0] for entry in re.findall(r'"([^"]+)"', block.group(1))}

    sections = content_list(root / "course-info.yaml") or []
    return [
        f"course-info.yaml lists section '{name}', but course.gpr's Source_Dirs has no entry for "
        f'it -- add "{name}/**", or gprbuild cannot see one file in the chapter'
        for name in sections if name not in listed
    ]


def check_unit_names(root: Path) -> list[str]:
    """A task's unit ends with its directory name, and every unit in the course is distinct.

    This exists in place of a prefix. Exercises used to be named `Imp_Hello_Greet` -- section,
    lesson, task -- because the whole course is one GNAT project, so every library-level unit shares
    one namespace and two tasks called `Greet` would collide. That bought safety at the cost of
    teaching beginners, by example on page one, a naming style no Ada programmer uses.

    So the collision the prefix prevented is caught here instead, and only the tasks that actually
    collide pay for it. `Colors` is three separate exercises in the original labs -- Strongly Typed
    Language, Records, Privacy -- and `Directions`, `List of Names`, `Simple todo list`,
    `Price list` and `List of events` are each two. One keeps the plain name and the others take a
    chapter qualifier: `Record_Colors`, `Private_Colors`. Which one goes plain is the author's
    choice, deliberately: fixing it to "whichever comes first" would make inserting a chapter
    rename tasks in chapters nobody touched.

    Hence *ends with* rather than *equals*. It still pins the name to the task -- `Foo_Bar` in a
    task called Colors fails -- while leaving the qualifier free. Uniqueness is checked separately,
    and is the half that gprbuild would otherwise enforce with a less helpful message.

    Only the parent of a child unit is checked, because `Operations.Test` lives in
    `operations-test.ads` and nothing about `test` should have to name the task. Uniqueness still
    considers the whole stem, so a parent and its child are two units and not a collision.

    Reported both ways round, as `check_structure` does, because a unit that disagrees with its
    file fails at compile time and loudly, while a unit that disagrees with its directory does not
    fail at all -- it just leaves the student opening `classify.adb` from a task called something
    else.
    """
    problems: list[str] = []
    seen: dict[str, Path] = {}
    # A package is two files -- `foo.ads` and `foo.adb` -- and one unit. Grouping by stem before
    # checking is what keeps a package task from reporting itself as a duplicate of itself.
    for task, units in sorted(task_units(root).items()):
        expected = task.name.replace(" ", "_")

        for unit, source in sorted(units.items()):
            # A child unit is `parent-child` on disk -- `Operations.Test` is `operations-test.ads`
            # -- and it is the parent that has to be named for the task. Checking the whole stem
            # would reject every child package in the course, starting with the one the Modular
            # Programming lab asks for.
            root = unit.split("-", 1)[0]
            if not root.lower().endswith(expected.lower()):
                problems.append(
                    f"{source.name} sits in the task '{task.name}', so its unit should be "
                    f"{expected}, or {expected} behind a qualifier where that name is taken -- a "
                    f"student opening this task gets a file named after something else"
                )
            if unit.lower() in seen:
                # By task, not by file name: a collision means the file names are identical, so
                # printing those twice says nothing about where either of them is.
                there = seen[unit.lower()]
                problems.append(
                    f"'{task.parent.name}/{task.name}' and '{there.parent.name}/{there.name}' are "
                    f"both unit {unit} -- the course is one GNAT project, so they share a namespace "
                    f"and gprbuild will refuse it. Qualify one with its chapter, as in "
                    f"Record_{expected}"
                )
            seen[unit.lower()] = task

    if not seen:
        problems.append("no task sources found at all, so this check proves nothing")
    return problems


def task_units(root: Path) -> dict[Path, dict[str, Path]]:
    """Every task's source directory, as unit name to one representative file.

    A unit is a file stem, so a package's spec and body collapse to one entry -- which is the whole
    reason this exists rather than a glob at the call site. From Modular Programming onward an
    exercise is a package, and a two-file task checked file by file reports itself colliding with
    itself.

    The body is preferred as the representative when a task has both, because it is the file a
    student opens: a spec of an exercise is usually given, and the body is the part with the hole
    in it.
    """
    tasks: dict[Path, dict[str, Path]] = {}
    for source in sorted(root.glob("*/*/*/src/*.ad[sb]")):
        units = tasks.setdefault(source.parent.parent, {})
        if source.suffix == ".adb" or source.stem not in units:
            units[source.stem] = source
    return tasks


def check_additional_files(root: Path) -> list[str]:
    """`additional_files` must name course content, and nothing the build produced.

    The course editor rebuilds this list by scanning the project, and it counts everything that
    is not part of a task -- including obj/ and bin/, which a GNAT project puts inside the course
    directory because that is where gprbuild wants them. It had swept 378 object files, .ali
    files and executables into course-info.yaml before anyone noticed.

    Nothing failed while they were merely listed. What failed was Course Preview, which tries to
    read every additional file and stops on the first one missing -- and they go missing the
    moment anyone runs `rm -rf obj bin`, which `--clean` does. So the symptom appeared far from
    the cause, in a feature none of the other checks exercise.

    What triggers the sweep is not known, and two confident explanations of it have already been
    wrong. Only the observations are worth recording:

      *  Before /obj and /bin were added to .courseignore, every commit for five chapters carried
         the sweep. Since adding them, no commit has.
      *  It reappeared in the working tree once anyway, 184 entries, and a deliberate attempt to
         reproduce it -- open the IDE, rebuild the whole course underneath it, quit -- did not.

    So .courseignore helps and cannot be relied on, and this check is what actually holds the
    line. It holds it by refusing to run, which keeps the state out of a commit whatever put it
    there. Run it with --structure immediately before committing: it is the cheap half, and the
    gap it closes is the editor writing between a full validation and the commit that follows.
    """
    info = root / "course-info.yaml"
    if not info.is_file():
        return ["course-info.yaml is missing"]

    listed: list[str] = []
    inside = False
    for line in info.read_text(encoding="utf-8").split("\n"):
        if re.match(r"^additional_files:\s*$", line):
            inside = True
            continue
        if inside:
            entry = re.match(r"^\s+-\s*name:\s*(.+?)\s*$", line)
            if entry:
                listed.append(entry.group(1).strip("\"'"))
            elif line.strip() and not re.match(r"^\s+\w+:", line):
                break

    problems: list[str] = []
    for name in listed:
        first = name.split("/", 1)[0]
        if first in {"obj", "bin"}:
            problems.append(
                f"course-info.yaml lists build output as an additional file: {name}. The course "
                f"editor scans obj/ and bin/ into that list; delete every such entry, because "
                f"Course Preview reads them all and fails on the first one that is gone"
            )
        elif not (root / name).is_file():
            problems.append(
                f"course-info.yaml lists additional file {name}, which does not exist -- Course "
                f"Preview will refuse to start"
            )
    #  Report the sweep once rather than 378 times.
    swept = [p for p in problems if "build output" in p]
    if len(swept) > 3:
        problems = [p for p in problems if p not in swept]
        problems.insert(
            0,
            f"course-info.yaml lists {len(swept)} build-output files as additional files, "
            f"starting with {listed[0] if listed else '?'} -- the course editor swept obj/ and "
            f"bin/ into it. Remove them all.",
        )
    return problems


def check_structure(root: Path) -> list[str]:
    """Every directory listed must exist, and every directory present must be listed.

    Both directions, because they fail differently and both fail quietly. A name with no directory
    stops JetBrains Academy loading the course. A directory with no name is worse: the task is
    simply absent from the course the student sees, while this script -- which finds tasks by
    globbing -- checks it and reports ok. That is a task that passes every check and does not
    exist.

    And the mirror of that, which is how it was found: a task directory that IS listed but has no
    `task-info.yaml`. The student sees it -- JetBrains Academy has a name for it -- and the run
    loop globs `*/*/*/task-info.yaml`, so it checks nothing. It turned up next door in
    advanced-ada-course, where twenty listed task directories and six info files produced a
    cheerful "all 6 task(s) good".
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

    #  The other way round: listed, present, and carrying nothing the run loop can find.
    for lesson_info in sorted(root.glob("*/*/lesson-info.yaml")):
        for name in content_list(lesson_info) or []:
            task = lesson_info.parent / name
            if task.is_dir() and not (task / "task-info.yaml").is_file():
                where = task.relative_to(root) if task.is_relative_to(root) else task
                problems.append(
                    f"'{where}' is listed as a task and has no task-info.yaml -- a student sees "
                    f"it and this script does not, so it would be shipped unchecked"
                )
    return problems


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--solved", action="store_true", help="skip the unsolved half")
    parser.add_argument("--structure", action="store_true",
                        help="only the structural checks, which compile nothing and take no time")
    parser.add_argument("--clean", action="store_true",
                        help="delete obj/ and bin/ first, so nothing is inherited from a previous run")
    args = parser.parse_args()

    root = Path.cwd()
    if not (root / "course.gpr").is_file():
        print("run this from the course root", file=sys.stderr)
        return 2

    #  Not the default, because it costs about a minute and most runs are iterating on one
    #  chapter. But it is what a verdict should be taken from: a warm obj/ has already answered
    #  some of the questions this script is asking, and the one time it disagreed with a cold run
    #  -- a spec that compiles only because its body was compiled first -- the warm answer was the
    #  wrong one.
    if args.clean:
        for derived in ("obj", "bin"):
            shutil.rmtree(root / derived, ignore_errors=True)

    structure = (check_structure(root) + check_source_dirs(root) + check_mains(root)
                 + check_unit_names(root) + check_additional_files(root))
    if structure:
        for problem in structure:
            print(f"  STRUCTURE  {problem}", file=sys.stderr)
        return 1
    print("  ok       structure: content lists match directories, every section has a Source_Dirs\n"
          "           entry, `for Main use` matches the sources that are runnable programs, every\n"
          "           unit is named for its task, and additional_files names course content\n"
          "           rather than build output")

    #  The point of --structure is to be runnable in the second before a commit, when a full
    #  run has already passed and the only worry is what the course editor did since.
    if args.structure:
        return 0

    failures: list[str] = []
    tasks = [read_task(p) for p in sorted(root.glob("*/*/*/task-info.yaml"))]
    if not tasks:
        print("no tasks found", file=sys.stderr)
        return 2

    for task in tasks:
        if task.kind == "theory":
            bodies = {s for s in task.sources if s.suffix == ".adb"}
            for source in task.sources:
                if source.suffix == ".ads" and source.with_suffix(".adb") in bodies:
                    # A spec is compiled as part of its body, and `gprbuild -c` on one by itself
                    # says so: "cannot generate code for file <x>.ads (package spec)". Whether
                    # that is reached depends on which of the two task-info.yaml happens to list
                    # first, and on whether obj/ is warm -- so it is skipped rather than ordered
                    # around. A spec with no body compiles on its own and is not skipped.
                    print(f"  ok       {task.name} ({source.name}, compiled with its body)")
                    continue
                if source.suffix not in {".ads", ".adb"}:
                    # A C source is compiled as part of whatever Ada unit imports it, never on
                    # its own. Naming one on gprbuild's command line makes it a main, and the
                    # link then fails for want of a _main -- measured. They are listed in
                    # task-info.yaml so a student can read them, not so this can build them.
                    print(f"  ok       {task.name} ({source.name}, built with its Ada caller)")
                    continue
                # Theory examples are compiled, not judged: several of AdaCore's illustrate a
                # runtime failure on purpose, and some tasks are packages with no main at all. A
                # compile error is still a real defect, and the compiler's exit status is the
                # whole question -- so nothing here is linked or run. See `compiles` for what
                # asking the other way cost.
                ok, output = compiles(source, root)
                if not ok:
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
