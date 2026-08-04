## Exercise: Money

Currency, to the cent, with no rounding error to argue about.

### The type

```adasnippet
type Amount is delta 10.0 ** (-2) digits 9;
```

Nine digits, two after the point — up to `9_999_999.99`, counted in whole cents.

### What to write

```adasnippet
function Add (A, B : Amount) return Amount;
function Times (A : Amount; Count : Natural) return Amount;
function Split (A : Amount; Ways : Positive) return Amount;
function Remainder (A : Amount; Ways : Positive) return Amount;
```

- **`Add`** adds two amounts.
- **`Times`** is a price times a quantity.
- **`Split`** divides evenly, keeping whole cents. £10.00 three ways is £3.33.
- **`Remainder`** is what `Split` had to drop — a penny, in that case — so that nothing goes
  missing.

`Image` is written for you.

> [!NOTE]
> **Why this type exists.** In binary floating point `0.1 + 0.2` is not `0.3`; it is
> `0.30000000000000004`. Ten cents plus twenty cents is thirty cents, exactly, and a decimal
> fixed-point type says so because it is counting cents rather than approximating a fraction.
> The test compares the *text* of the result, so no tolerance is hiding anything.

> [!TIP]
> Fixed-point arithmetic with integers needs no conversion: `A * Count` and `A / Ways` are both
> `Amount` already. It is fixed **times fixed** that needs one — see the next lesson.

> [!TIP]
> `Remainder` is the amount less what the shares actually came to. Three shares of £3.33 is
> £9.99, so the remainder is a penny. The test checks that the shares and the remainder add back
> up to what you started with, which is the property that actually matters when it is somebody's
> money.

> [!NOTE]
> This exercise is original to this course. AdaCore's *Laboratories* has no Fixed-Point Types
> chapter, so both of this chapter's exercises were written for it rather than adapted.

Press **Check** when you are done.
