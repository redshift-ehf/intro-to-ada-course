# Random floats

```adasnippet
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

G : Generator;
X : Uniformly_Distributed;

Reset (G);
X := Random (G);
```

`Uniformly_Distributed` is `Float range 0.0 .. 1.0`. This package is not generic — one range, one
type, no instantiation.

## The generator is an object

Not a hidden global. Two generators are independent, which is what makes this usable from more than
one task without them interfering.

## Reset, with or without a seed

```adasnippet
Reset (G);        --  seeded from something time-varying: a different run every time
Reset (G, 42);    --  seeded explicitly: the same sequence, every time
```

**A test wants the second.** Reproducibility is the difference between a failing test you can
investigate and one you cannot.

The example resets two generators from the same seed and shows they produce identical sequences.

## Another range

Arithmetic, not another package:

```adasnippet
Low + Random (G) * (High - Low)
```

> [!NOTE]
> `Reset` with no argument is not guaranteed to differ between two programs started in the same
> instant. If you need distinct streams, seed them distinctly.

> [!TIP]
> This is not a cryptographic generator and does not claim to be. For keys and nonces, use a
> library that says so on the label.
