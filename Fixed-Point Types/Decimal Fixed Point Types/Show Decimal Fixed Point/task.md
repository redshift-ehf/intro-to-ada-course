# Decimal fixed-point types

Floating point is not always the right answer. Its rounding error is unacceptable in money, and
some hardware has no floating-point unit at all. A **fixed-point** type is a scaled integer: it has
no exponent, and its steps are a fixed size.

```adasnippet
type <name> is delta <delta-value> digits <digits-value>;
```

Two numbers make the type:

- **`delta`** — how fine the steps are. `delta 0.01` counts in hundredths.
- **`digits`** — how many decimal digits there are altogether.

```adasnippet
type Decimal is delta 10.0 ** (-2) digits 3;
```

Three digits, two of them after the point, so this runs from `-9.99` to `9.99`. Change the delta to
`10.0 ** (0)` and the same three digits run from `-999` to `999`. The digits are your budget; the
delta says where you spend them.

## The delta must be a power of ten

That is what makes it *decimal* fixed point, and it is enforced:

```adasnippet
type Bad_1 is delta 2.0 ** (-1) digits 3;   --  rejected
type Bad_2 is delta 0.125 digits 3;         --  rejected
```

Both are perfectly good scale factors. They are just not powers of ten, and so belong to the
*ordinary* fixed-point types in the next lesson.

> [!NOTE]
> `10.0 ** (-2)` and `0.01` mean the same thing here. The exponent form is worth preferring
> because it says "two decimal places" at a glance, which is usually what you were actually
> deciding.

Press **Run** to see three types with the same digits and different deltas.
