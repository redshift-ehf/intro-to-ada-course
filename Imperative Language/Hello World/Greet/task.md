## Hello world

Ada is a multi-paradigm language with support for object orientation and some elements of
functional programming, but its core is a simple, coherent procedural/imperative language akin to
C or Pascal.

Here's a very simple imperative Ada program:

```adasnippet
with Ada.Text_IO;

procedure Imp_Hello_Greet is
begin
   --  Print "Hello, World!" to the screen
   Ada.Text_IO.Put_Line ("Hello, World!");
end Imp_Hello_Greet;
```

Press the **Run** button in the gutter beside the procedure to compile and run it.

Three things are worth noticing straight away.

`with Ada.Text_IO;` makes another package visible to this one. Ada has no preprocessor and no
textual inclusion — `with` is a real dependency on a compiled unit, and the compiler will tell you
if that unit does not exist or does not export what you asked for.

Every subprogram is `procedure`/`function` … `is` … `begin` … `end`, and the name is repeated after
`end`. That repetition looks redundant until you are twenty lines into nested blocks, at which point
the compiler is checking that you closed the thing you meant to close.

Comments start with `--` and run to the end of the line. There is no block comment form, which is
deliberate: a comment can never accidentally swallow code below it.

> The original of this example names the procedure `Greet`. Here every unit has a name unique across
> the whole course, because the course is one GNAT project — see the repository README for why.

---

<div class="hint">
The Run button appears beside any subprogram that takes no arguments, which is Ada's rule for a
main program — a program has to be startable with nothing.

So some later exercises have a Run button and some do not, and the difference is exactly that rule.
`Imp_Hello_Say` in the next task takes no arguments, so you can run it and watch it print. The one
after takes a name to greet, which makes it a subprogram rather than a program, and it is checked
rather than run.
</div>
