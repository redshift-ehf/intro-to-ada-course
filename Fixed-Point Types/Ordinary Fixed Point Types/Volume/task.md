## Exercise: Volume

A gain, in steps of 1/256.

### The type

```adasnippet
type Gain is delta 2.0 ** (-8) range 0.0 .. 2.0;
```

The range runs to 2.0 rather than 1.0 **on purpose**, and the declaration says why: at this delta,
`range 0.0 .. 1.0` fits in eight bits as 0 .. 255 steps, 1.0 is the 256th, and the bound gets
adjusted down — taking unity gain, the value this package most needs, with it. Read the comment on
the type; it is the lesson before this one, in the place where it bites.

### What to write

```adasnippet
function Scale (A, B : Gain) return Gain;
function Mix (A, B : Gain) return Gain;
function Fade (G : Gain; Steps : Natural) return Gain;
```

- **`Scale`** applies two gains one after the other — their product.
- **`Mix`** is halfway between them.
- **`Fade`** halves `Steps` times over.

`Is_Silent` is written for you.

> [!TIP]
> **`Scale` needs a conversion and will not compile without one.** Fixed times fixed is
> `universal_fixed` in Ada — a type with no operations of its own — so the result must be
> converted back before it can be returned: `Gain (A * B)`. Fixed times *integer* needs nothing,
> which is why the Money exercise never ran into this.

> [!TIP]
> For `Mix`, halve each one *before* adding. Adding first can exceed `Gain'Last` and raise
> `Constraint_Error` before the division ever runs — a real bug that only appears at the top of
> the range, which is exactly where nobody tests.

> [!NOTE]
> **The point of `Fade`.** The delta is 1/256, so eight halvings from full reach the smallest
> value the type has. The ninth has nowhere to go: a fixed-point type has no exponent, so the
> value does not get smaller — it becomes zero. The test checks both the eighth and the ninth.

> [!NOTE]
> This exercise is original to this course — see the note in Money.

Press **Check** when you are done.
