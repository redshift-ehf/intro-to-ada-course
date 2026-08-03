# Integers

An integer type is declared by its **bounds**:

```adasnippet
type My_Int is range -1 .. 20;
```

That is the entire declaration. There is no `int`, `long` or `short` to choose between: you say
which values you need, and the compiler finds a representation that holds them.

## Operational semantics

Ada checks that a value fits its type. What it does *not* do is check every step along the way:

```adasnippet
A    : constant My_Int := 12;
B    : constant My_Int := 15;
Mean : constant My_Int := (A + B) / 2;
```

`A + B` is 27, which is outside `My_Int` — and this is correct, and does not raise. Only the value
being stored has to fit, and 13 does. Intermediate results are computed with enough range to hold
them, so an expression that arrives somewhere sensible is allowed to pass through somewhere that
is not.

> [!TIP]
> Change `Mean` to just `A + B` and press **Run**. Now the stored result is out of range, and you
> get a `Constraint_Error` — reported at compile time when the compiler can see it coming, and at
> run time when it cannot.
