# Foreign variables

Variables cross the boundary as readily as subprograms, and with the same two aspects.

## Using a C global in Ada

```adasnippet
Fv_Call_Count : int
  with Import, Convention => C;
```

This is not a copy. It *is* C's `fv_call_count` — the same storage, under a second name. C
increments it; Ada reads the increment.

## Using an Ada variable in C

```adasnippet
Fv_From_Ada : int := 0
  with Export, Convention => C;
```

and in C:

```c
extern int fv_from_ada;

void fv_bump_ada (void) { fv_from_ada += 100; }
```

Again one variable, two names, and whichever side declares it also initialises it.

> [!NOTE]
> An imported variable has no initial value of its own — the exporting side owns that. Writing
> `X : int := 0 with Import, ...` is a mistake: the initialisation is ignored, and the value you
> get is whatever C put there.

> [!TIP]
> Shared mutable state across a language boundary is exactly as risky as shared mutable state
> anywhere, and now neither language's tooling can see the whole picture. Prefer a function that
> returns the value to a variable both sides poke at.

Press **Run**: C counts its own calls, then reaches into Ada's variable and adds to it twice.
