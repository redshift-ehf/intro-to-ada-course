## Exercise: Rotation

Walk a point once round the origin, using complex multiplication instead of sines and cosines.

**Multiplying by a complex number of modulus 1 *is* a rotation** — the arguments add and the moduli
multiply. That is the whole exercise.

### The package

```adasnippet
type Complex_Points is array (Positive range <>) of Complex;

subtype Angle is Float;
type Angle_Array is array (Positive range <>) of Angle;

function Positions (N : Positive) return Complex_Points;
function To_Angles (C : Complex_Points) return Angle_Array;
```

### What to write

Both bodies.

**`Positions`** returns the `N + 1` positions of a point that starts at `(1.0, 0.0)` and goes once
round in `N` equal steps. The last one is the first one again.

For four slices:

```
Point #1: ( 1.0,  0.0)
Point #2: ( 0.0,  1.0)
Point #3: (-1.0,  0.0)
Point #4: ( 0.0, -1.0)
Point #5: ( 1.0,  0.0)
```

**`To_Angles`** gives the same path in degrees:

```
   0.00    90.00   180.00   -90.00     0.00
```

> [!TIP]
> One step is `Compose_From_Polar (1.0, 2.0 * Pi / Float (N))`. Then each position is the previous
> one times that step — no trigonometry in the loop at all.

> [!TIP]
> `Argument` gives radians from `-Pi` to `Pi`. Degrees are `× 180.0 / Pi`, and the range is why
> the fourth angle is **-90 and not 270**.

> [!NOTE]
> The labs call this function `Rotation`, the same name as its package. That will not compile at
> the call site: with a `use` clause the bare name resolves to the package, and only
> `Rotation.Rotation (4)` works — measured both ways before this exercise was written. Hence
> `Positions`.

> [!NOTE]
> **A half turn comes back as -180, not 180.** `cos (Pi/2)` in `Float` is a small negative number
> rather than zero, so the accumulated rounding leaves the point just below the negative real axis
> and `Argument` answers accordingly. They are the same angle; the test compares the magnitude,
> and says so.
>
> That is not a defect in your answer or in the library. It is what floating point is, and this
> exercise is a good place to meet it.

Press **Check** when you are done.
