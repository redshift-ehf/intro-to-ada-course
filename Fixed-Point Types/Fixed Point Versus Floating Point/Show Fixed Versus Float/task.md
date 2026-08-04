# Fixed-point vs. floating-point

The difference is one thing: **a fixed-point type has no exponent.**

Everything else follows.

## Small values vanish

A floating-point type represents a small number by moving its exponent. A fixed-point type cannot
— its steps are a fixed size, and there is nothing between zero and one step:

```adasnippet
D : Decimal  := 0.01;   --  delta 10.0 ** (-2)
F : Float_32 := 0.01;

D := D / 2;    --  0.00 -- the value is gone
F := F / 2.0;  --  0.005 -- the exponent moved
```

Neither is wrong. They answer different questions. If 0.005 is meaningless in your problem —
half a cent, half a millimetre on a ruler marked in millimetres — then rounding it away is
correct, and silently keeping it is what would mislead you.

## Which to reach for

| | Fixed-point | Floating-point |
|---|---|---|
| Steps | one fixed size | vary with magnitude |
| Small values | become zero below the delta | keep going |
| Exact decimals | yes, if the delta is decimal | no |
| Hardware | integer registers | needs an FPU, or software emulation |

**Fixed-point** for money, for sensor counts, for anything where the unit is real and the
arithmetic should be exact in it — and for embedded work where there is no floating-point unit, or
where cycles and power are budgeted.

**Floating-point** for physical quantities spanning many orders of magnitude, where relative
precision matters more than absolute.

> [!NOTE]
> Fixed-point arithmetic mostly compiles to integer instructions. The compiler is scaling
> integers for you and applying slightly different numeric rules — which is why it is fast, and
> why it is available on hardware that has no notion of a floating-point number at all.
