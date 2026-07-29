# Security

## Reporting a vulnerability

Open a [private security advisory](https://github.com/redshift-ehf/intro-to-ada-course/security/advisories/new)
on this repository — it is visible only to maintainers — or email **developer@redshift.is** if you
would rather not use GitHub, or cannot.

Please do not open a public issue for a vulnerability. Reports are handled confidentially, and you
will get an acknowledgement.

## What this repository is, and what that means for its surface

This is course content: Ada source, task descriptions in Markdown, and YAML describing how the two
fit together. It downloads nothing, contacts nothing, and pins no dependencies. That makes its
attack surface small and specific rather than absent.

**The course ships Ada that a student compiles and runs on their own machine.** Every exercise and
every theory task is built by `gprbuild` and executed locally when the student presses Run or Check.
Anything committed here therefore runs, unreviewed, on the machine of whoever takes the course. That
is the surface worth reporting against: a task whose source or test does something beyond what the
lesson describes.

The same applies to `course.gpr` and to `harness/ada_check.adb`, which every exercise links against.
A change there reaches every task at once.

**`scripts/check_course.py` runs the whole course.** It compiles and executes every task twice, once
as committed and once with the placeholder substituted. It is a maintainer tool, is excluded from
what students receive by `.courseignore`, and takes paths from the repository rather than from
input — but it does execute course code by design.

## Scope

This repository is the course. Vulnerabilities in the tooling belong elsewhere: the IntelliJ plugin
that runs the course is [redshift-ehf/intellij-ada](https://github.com/redshift-ehf/intellij-ada),
the compiler is [AdaCore's](https://github.com/AdaCore/gnat), and the course-format machinery is
[JetBrains'](https://github.com/JetBrains/educational-plugin). If you are not sure which, report it
here and it will be routed.
