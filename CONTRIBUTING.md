# Contributing

Corrections are welcome, especially to the exercises. A task that is ambiguous, or whose test
accepts something the description forbids, is a bug in the course and worth reporting even without a
fix attached.

## The licence has a consequence for contributions

This course is under [CC BY-SA 4.0](LICENSE), because it is an adaptation of AdaCore's *Introduction
to Ada* and ShareAlike carries forward. Contributing means agreeing that your contribution is
released under the same licence. That is not the usual MIT-style arrangement other course
repositories use, and it is deliberate — see [LICENSE](LICENSE) for why.

If you adapt further material from AdaCore, keep the attribution with it. Every lesson already
carries it once, at the course level, rather than repeated on every page.

## Run the checker before opening a pull request

```
scripts/check_course.py
```

It compiles and runs every task twice, and the second pass is the one that matters:

- **solved** — the file as committed compiles and its test passes.
- **unsolved** — with the placeholder substituted in, the test must **fail**.

That second assertion catches the failure mode nothing else does: a placeholder whose span does not
actually remove the answer. Such a task looks correct in every screenshot, passes the solved check,
and quietly hands the student a completed exercise.

`--solved` skips the slow half when you are iterating. `--clean` empties `obj/` and `bin/` first,
and is what a verdict should be taken from — a warm `obj/` has already answered some of what the
checker is asking, and the one time a warm run disagreed with a cold one, the warm answer was the
wrong one.

Theory tasks are compiled but not run — `gprbuild -c`, and the exit status is the whole check. They
exist to be read and to have a Run button that works, many print things no test should assert on,
and several are packages with no main to run in the first place.

## Two things that look like mistakes and are not

**`programming_language: Plain text` in `course-info.yaml`.** It is an Ada course. The declaration
works around a closed map in the course format that has no Ada entry, and "fixing" it stops the
course loading entirely. [NEXT.md](NEXT.md) explains the wall in full — read it before touching that
line.

**`*-remote-info.yaml` is gitignored.** Those files are Marketplace identity, assigned locally, and
this course is not on the Marketplace. If it is ever published there, commit them: they are how an
update lands on the existing entry instead of creating a second one.

## Structure

Each task is a directory with `task-info.yaml`, `task.md`, and `src/`. Exercises (`type: edu`) also
carry `tests/`; theory tasks (`type: theory`) do not, and should not.

`course.gpr` at the root spans every lesson through `Source_Dirs`, which is what lets the language
server load the whole course as one project rather than one task at a time. Adding a **section**
means adding `"<Section>/**"` there too; the checker will tell you if you forget, which it did not
used to.

`harness/ada_check.adb` is linked by every exercise, so a change to it reaches all of them at once.

## Reporting without a fix

Open an issue. For anything security-relevant, see [SECURITY.md](SECURITY.md) instead — course code
runs on a student's machine, so it is worth treating as such.
