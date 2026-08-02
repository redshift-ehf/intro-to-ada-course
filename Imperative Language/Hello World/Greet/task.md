# Imperative Language

Ada is a multi-paradigm language with support for object orientation and some elements of
functional programming, but its core is a simple, coherent procedural/imperative language akin to
C or Pascal.

> [!NOTE]
> **In other languages**
>
> One important distinction between Ada and a language like C is that statements and expressions are very clearly distinguished. In Ada, if you try to use an expression where a statement is required then your program will fail to compile. This rule supports a useful stylistic principle: expressions are intended to deliver values, not to have side effects. It can also prevent some programming errors, such as mistakenly using the equality operator `=` instead of the assignment operation `:=` in an assignment statement.

## Hello world

Here's a very simple imperative Ada program:

```adasnippet
with Ada.Text_IO;

procedure Greet is
begin
   --  Print "Hello, World!" to the screen
   Ada.Text_IO.Put_Line ("Hello, World!");
end Greet;
```

which we'll assume is in the source file `greet.adb`.

> [!TIP]
> Press the green **Run** button in the gutter beside the procedure in the source view to compile and run it.

If you compile that source with the GNAT compiler and run the executable, you will get an unsurprising result.

```shell
$ gprbuild greet.adb
using project file [...]_default.gpr
Compile
[Ada]          greet.adb
Bind
[gprbind]      greet.bexch
[Ada]          greet.ali
Link
[link]         greet.adb

$ ./greet
Hello, World!
$
```

There are several noteworthy things in the above program:

* A subprogram in Ada can be either a procedure or a function. A procedure, as illustrated above, does not return a value when called.
* `with` is used to reference external modules that are needed in the procedure. This is similar to `import` in various languages or roughly similar to `#include` in C and C++. We'll see later how they work in detail. Here, we are requesting a standard library module, the `Ada.Text_IO` package, which contains a procedure to print text on the screen: `Put_Line`.
* `Greet` is a procedure, and the main entry point for our first program. Unlike in C or C++, it can be named anything you prefer. The builder will determine the entry point. In our simple example, **gprbuild**, GNAT's builder, will use the file you passed as parameter.
* `Put_Line` is a procedure, just like `Greet`, except it is declared in the `Ada.Text_IO` module. It is the Ada equivalent of C's `printf`.
* Comments start with `--` and go to the end of the line. There is no multi-line comment syntax, that is, it is not possible to start a comment in one line and continue it in the next line. The only way to create multiple lines of comments in Ada is by using `--` on each line. For example:

```adasnippet
--  We start a comment in this line...
--  and we continue on the second line...
```

> [!NOTE]
> **In other languages**
>
> Procedures are similar to functions in C or C++ that return `void`. We'll see later how to declare functions in Ada.

---

<div class="hint">
The Run button appears beside any subprogram that takes no arguments, which is Ada's rule for a
main program — a program has to be startable with nothing.

So some later exercises have a Run button and some do not, and the difference is exactly that rule.
`Say_Hello` in the next task takes no arguments, so you can run it and watch it print. The one
after takes a name to greet, which makes it a subprogram rather than a program, and it is checked
rather than run.
</div>
