## Exercise: C Statistics

A full round trip: **Ada calls C, and that C calls back into Ada.**

### The pieces

`summary.c` is given, and defines nothing of its own:

```c
extern int ada_mean (int a, int b);
extern int ada_call_count;

int summarise (int a, int b)
{
    ada_call_count++;
    return ada_mean (a, b);
}
```

Both names it uses come from Ada. It has no idea of that.

### Read the spec first

The two exports are the interesting part, and they are **given**:

```adasnippet
function Mean (A, B : C_Int) return C_Int
  with Export, Convention => C, External_Name => "ada_mean";

Call_Count : C_Int := 0
  with Export, Convention => C, External_Name => "ada_call_count";
```

`External_Name` must match what the C file declares, character for character.

They are given rather than asked for because **without them the program does not link at all**.
`summary.c` declares both `extern`, so removing either leaves an undefined symbol and there is no
starting state for you to work from — the exercise would be a link error rather than a failing
test. Read them, then write the parts underneath.

### What to write

```adasnippet
function Mean (A, B : C_Int) return C_Int;   --  the average of the two
procedure Reset;                              --  Call_Count back to nought
```

`Summarise` and `Summarise_Three` are already imported for you.

> [!NOTE]
> This works only because `C_Statistics` is a **package**. An exported subprogram must be at
> library level; nested inside a procedure, GNAT refuses it. That is why the Foreign Subprograms
> lesson could show `Export` but not run it.

> [!TIP]
> The test proves the C really ran, rather than trusting it: `Call_Count` is incremented by
> `summary.c` and read from Ada. If your `Mean` were being called directly, the count would stay
> at nought.

> [!NOTE]
> `Interfaces.C.int` has no visible arithmetic unless you say so. The body has
> `use type Interfaces.C.int;` for exactly that — without it, `A + B` is *"there is no applicable
> operator +"*.

> [!NOTE]
> This exercise is original to this course — see the note in C Strings.

Press **Check** when you are done.
