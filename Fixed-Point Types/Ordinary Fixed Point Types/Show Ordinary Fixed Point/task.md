# Ordinary fixed-point types

Same idea, one restriction lifted: the delta need not be a power of ten.

```adasnippet
type <name> is delta <delta-value> range <lower> .. <upper>;
```

No `digits` this time — a `range` instead, and the delta and the range together decide how many
bits it takes.

```adasnippet
type Fraction is delta 2.0 ** (-8) range 0.0 .. 1.0;
type Inv_Trig is delta 0.0005 range -Pi / 2.0 .. Pi / 2.0;
```

A power of two is the common case, because that is what the hardware underneath is doing anyway —
a shift rather than a divide. But any delta is allowed, including one chosen to suit the problem,
as `Inv_Trig` does.

## The high bound may not be the one you asked for

This catches everybody once.

`Fraction` above is declared up to `1.0` and **does not reach it**. At a delta of 1/256 the range
0 .. 1.0 is 257 distinct steps, which does not fit in eight bits — so the declared bound is
adjusted *down* by one delta, and `Fraction'Last` is 0.99609375.

GNAT says so plainly when it happens:

```
warning: declared high bound of type "Fraction" is outside type range
warning: high bound adjusted down by delta (RM 3.5.9(13))
```

Widen the range to `0.0 .. 2.0` and it takes sixteen bits, where the bound survives intact. The
example prints both so you can see the difference.

> [!TIP]
> If a particular value matters — unity gain, full scale, exactly 1.0 — do not assume the
> declared bound includes it. Check `'Last`, or give the type room. The next exercise is built
> on precisely this, and says why in its own declaration.

> [!NOTE]
> The example also warns that `Inv_Trig`'s delta is "not a multiple of Small". That is the same
> story from the other side: you asked for steps of 0.0005, the compiler picked a power of two no
> larger, and the two do not divide evenly. The delta is a *maximum* step size, not a promise of
> exactly that step.
