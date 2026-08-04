## Exercise: Price Range

A price cannot be negative. Say so with a predicate rather than a range.

### The types

```adasnippet
type Amount is delta 10.0 ** (-2) digits 12;

subtype Price is Amount
  with Dynamic_Predicate => ... ;
```

### What to write

The predicate. A `Price` is an `Amount` that is not negative.

> [!NOTE]
> **The obvious way is a range**: `subtype Price is Amount range 0.0 .. Amount'Last;` — and for
> this rule it is the better way. The exercise uses a predicate so you can see the difference,
> which is real and shows up in two places:
>
> - a range violation raises `Constraint_Error`; a predicate violation raises `Assertion_Error`;
> - a range is always checked, and a predicate only when `-gnata` is on.
>
> Reach for a predicate when the rule is not a range — "even", "one of these three", "consistent
> with that other component". For a lower bound, use the bound.

Press **Check** when you are done.
