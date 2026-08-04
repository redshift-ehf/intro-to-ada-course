## Exercise: Online Store

Two kinds of member, one price list, and a discount only one of them gets.

### The types

```adasnippet
type Amount is delta 10.0 ** (-2) digits 10;
subtype Percentage is Amount range 0.0 .. 1.0;

type Member is tagged record
   Start : Year_Number;
end record;

type Full_Member is new Member with record
   Discount : Percentage;
end record;
```

### What to write

The two `Full_Member` operations:

```adasnippet
overriding function Get_Status (M : Full_Member) return String;
overriding function Get_Price (M : Full_Member; P : Amount) return Amount;
```

- **`Get_Status`** returns `"Full Member"`. The parent returns `"Associate Member"`.
- **`Get_Price`** takes the discount off. An associate pays the price as it stands.

> [!TIP]
> `Amount` is decimal fixed-point, so `P * (1.0 - M.Discount)` is fixed times fixed —
> `universal_fixed`, which must be converted back: `Amount (...)`. The Fixed-Point Types rule,
> turning up in the middle of an OOP exercise.

> [!NOTE]
> **The test never asks what kind of member it has.** It holds all four in one
> `array of access Member'Class` and calls `Get_Status` and `Get_Price` on each; the tag picks
> the body every time. That is the whole point of the chapter, and it is why both operations
> have to be primitives of the type rather than a `case` somewhere.

> [!TIP]
> A full member with a discount of `0.00` pays full price — the case where the two bodies happen
> to agree. The test checks it, because a `Get_Price` that ignores the discount entirely would
> otherwise look right there.

Press **Check** when you are done.
