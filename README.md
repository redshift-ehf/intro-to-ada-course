# Introduction to Ada — a JetBrains Academy course

An adaptation of AdaCore's [Introduction to Ada](https://learn.adacore.com/courses/intro-to-ada/)
for JetBrains IDEs, with exercises adapted from its companion
[Introduction to Ada: Laboratories](https://learn.adacore.com/labs/intro-to-ada/).

> Adapted from *Introduction to Ada* by Raphaël Amiard and Gustavo A. Hoffmann,
> © 2018–2026 AdaCore, used under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).
> Changes were made: restructured as a JetBrains Academy course, with exercises adapted from
> *Introduction to Ada: Laboratories*. This adaptation is released under the same licence — see
> [LICENSE](LICENSE), which explains why it is not MIT like other courses.

## Requirements

- A JetBrains IDE with the **JetBrains Academy** plugin.
- The **Ada and SPARK** plugin, which provides the language server, the build integration and the
  test runner that checks your work.
- **GNAT** on your `PATH`. `alr toolchain --select` is the usual way to get one.

## Opening it

Not published to the Marketplace — see LICENSE for why. Use *Get from VCS* on the Welcome screen
against this repository, which opens it as a course directly.

## How it is put together

Read this before adding a chapter; each point below was measured rather than assumed, and each one
constrains the layout.

**One `course.gpr` for the whole course.** `gprbuild -P course.gpr <one_main>.adb` compiles that
main's closure alone, so an unfinished exercise cannot break the others — which is the isolation a
crate per exercise would have bought, without the cost. The cost it *would* have had is real: the
language server loads one project per IDE project, so a crate per exercise would leave you with
go-to-definition inside a single task at a time.

`for Main use` lists every task source that is a runnable program — see the Run button note below
for which those are, and why the list is not simply "the theory examples". It costs none of the
isolation above, since it only affects what a bare `gprbuild -P course.gpr` builds — checked with
an unfinished exercise in the tree, where the bare build succeeds because an exercise stub still
compiles.

**Every Ada compilation unit needs a globally unique name.** They all share one project, so
`greet` rather than `main`. This is enforced rather than trusted: gprbuild refuses the
whole project with `duplicate unit "..."` if two ever collide, so a mistake here fails loudly on
the next build rather than silently building the wrong file.

**Directory names are the titles students see.** JetBrains Academy takes section and lesson titles
from the directory name — only tasks can override it, with `custom_name`. So directories are named
`Imperative Language`, spaces and all. GPR accepts spaces in `Source_Dirs`; that was checked before
the layout was chosen.

**Every test main also shares one `bin/`**, so test program names must be unique too. A task's unit
is its directory name with spaces as underscores — `Say Hello` is `Say_Hello` in `say_hello.adb` —
and `Test_` in front for the test main.

That keeps task names unique across the whole course, which the single project requires. It used to
be bought with a `<section>_<lesson>_<task>` prefix, so a student's first line of Ada read
`procedure Imp_Hello_Greet`. `check_unit_names` in `scripts/check_course.py` holds the same
invariant without teaching a style no Ada programmer uses: a collision is now a named failure while
the author is looking at it, rather than something a mangled name made impossible in advance.

**An exercise goes where its prerequisites are taught, not where the labs filed it.** The
*Laboratories* companion is chaptered independently of the course, so some of its exercises need
material the matching course chapter has not covered. Where that happens the exercise moves
forward, and the reason is worth recording because the move is invisible afterwards:

| Exercise | Labs chapter | Ported into | Needed |
|---|---|---|---|
| Integers | Strongly typed language | Strongly Typed Language → Subtypes | derived types, subtypes |
| Simple todo list | More about types | More About Records → Records With Discriminant | access types, discriminants |
| Price list | More about types | Privacy → Abstract Data Types | decimal fixed-point, variant records |

Both were skipped when More About Types shipped, and the two were owed differently. *Price list*
recurs in the Privacy lab under the same name and as the same exercise, so it was ported once,
there, where every one of the four things it needs has been taught. *Simple todo list* was placed
by hand instead, in the chapter that teaches its discriminant — it is the one adapted exercise in a
chapter otherwise carrying original ones.

That second sentence used to say *Simple todo list* appears nowhere else, checked against every lab
chapter. It does appear again, in *Standard library: Containers*, and the labs say so outright:
"rewrite that exercise using vectors instead of arrays". So it is a second **exercise**, not a
second site for the same one — the array version keeps its discriminant, its `Last` and its "list
is full", and the vector version has none of the three. Both are in the course. They collide by
name, so the later one takes the chapter qualifier the naming rule provides:
`Containers_Simple_Todo_List`.

Nothing is outstanding.

**A first IDE open can delete a new section from `course-info.yaml`, so check `git status` after
one.** Every open rewrites that file from the course model the IDE built, about three seconds in.
Three chapters out of the eight watched for it came back with a `content:` naming everything except
the chapter just written; the new `section-info.yaml` was never touched at all, and nothing was
logged. The other five produced a byte-identical file and the new `section-info.yaml` was touched
immediately.

So it is not reliable, and the mechanism is not pinned down. A file cache predating the new
directories was the obvious candidate and does not survive the evidence: one of the chapters that
came through intact had its directories created with the IDE not running at all, which is the case
that explanation says should fail hardest. Nothing since has separated the three failures from the
five successes — same steps, same order, both outcomes.

What is reliable is the check and the repair. `check_structure` names any dropped section, so this
cannot ship silently; `git checkout -- course-info.yaml`, quit, and open again has produced
identical content every time. Do not resolve it by deleting the chapter directory that
`course-info.yaml` no longer mentions.

### One task

```
Imperative Language/            section  — title comes from this name
  Hello World/                  lesson   — and this one
    Greet/                      task     — task-info.yaml may override with custom_name
      task-info.yaml
      task.md                   description, with the attribution note
      src/greet.adb   visible; for an exercise, this is the SOLUTION
      tests/test_greet.adb   invisible; built on the Ada_Check harness
```

For an exercise, **the file committed here is the finished answer**. The IDE cuts out the span
named by the placeholder in `task-info.yaml` and puts `placeholder_text` there instead, which is
what a student first sees; "Peek Solution" reconstructs what is committed. There is no separate
stub file to keep in step.

**Placeholder text that needs leading whitespace must be a quoted scalar.** The placeholder span
covers the indentation as well as the statement, so the replacement has to carry its own — and a
`|-` block scalar strips the indentation common to its lines, which means indenting the content of
one changes nothing at all. Write `placeholder_text: "   --  …\n   null;"`. `check_course.py`
refuses to run on a form it cannot read rather than skipping the task.

Expect the IDE to rewrite what you wrote as `|2-` the first time it opens the task. That is not the
`|-` above but the explicit-indentation form, which keeps the leading whitespace, so it is the same
string — verified by the whole suite passing on the rewritten files. Take its version and commit it;
arguing with it only produces the same diff again on the next open.

**Read the `offset:` lines in that diff before you take it, though.** An open can also write back an
offset from a model built before you last edited the source. It happened once, to *C Strings*: the
IDE restored `1171`, byte-identical to the value committed before the edit that moved the span to
`1444`, and left the length and the text alone. Rendered, that placeholder lands in the middle of a
comment and the result does not compile. `check_course.py` catches it — building each exercise
unsolved is exactly the assertion that fails here — but only if you run it, and this arrives looking
like the harmless reformatting above. So: block scalars are the IDE's to decide, offsets are not.

**A Run button appears on whatever is a runnable program, exercise or not.** Ada's rule for a main
is a parameterless library-level subprogram, and that is exactly the rule the IDE's gutter marker
uses — so `for Main use` in `course.gpr` must name every task source that satisfies it, or the
button appears and then fails with no executable to run. `check_course.py` enforces the agreement
in both directions; it was added after `Say_Hello` slipped through.

Most exercises do take parameters and so are checked rather than run — which is the better trade:
the original labs read a single value from the command line, and a parameter can be supplied as
many times as the test likes. Each exercise is checked against several inputs including the
boundaries, so a solution that hardcodes the first expected answer fails on the second case.

### Code fences say `adasnippet`, not `ada`

```markdown
```adasnippet
with Ada.Text_IO;
```
```

Not a typo, and the generator must emit it. The task-description panel paints code from a `PsiFile`,
so a fence's language needs a parser — and the Ada plugin deliberately gives real Ada files none,
because that is what keeps the language server's semantic highlighting alive in the editor. The
plugin therefore ships a second language, `AdaSnippet`, that exists only to be quoted: same lexer,
same colours, its own parser. A fence labelled `ada` resolves to the real language and renders grey.

### The test harness

`harness/ada_check.{ads,adb}` is an ordinary Ada package that prints
[TeamCity service messages](https://www.jetbrains.com/help/teamcity/service-messages.html), which
is how a plain Ada program ends up populating the IDE's test tree. No AUnit, no gnattest, and
nothing to download: a test is a main that calls `Ada_Check.Check` and returns
`Ada_Check.Failures` as its exit status.

```ada
with Ada.Command_Line;
with Ada_Check;

procedure Test_Greet is
begin
   Ada_Check.Suite ("Hello World");
   Ada_Check.Equal ("greeting", Greeting, "Hello, World!");
   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Greet;
```

A test program that does not compile prints nothing at all, and the IDE reports that as a
compilation failure with clickable GNAT errors rather than as a broken test framework.
