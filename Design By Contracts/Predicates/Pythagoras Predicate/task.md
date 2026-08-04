## Exercise: Pythagorean Theorem — Predicate

State the theorem as a **predicate**: a rule about which values of the type are legal.

```adasnippet
type Right_Triangle is record
   H      : Length := 0;
   C1, C2 : Length := 0;
end record
  with Dynamic_Predicate => ... ;

function Init (H, C1, C2 : Length) return Right_Triangle is ((H, C1, C2));
```

Fill in the predicate: the square on the hypotenuse equals the sum of the squares on the other
two sides.

> [!TIP]
> A predicate refers to the value at hand by the **type's own name** — `Right_Triangle.H`, not
> `H`. That reads oddly the first time and is the standard form.

> [!NOTE]
> The default `(0, 0, 0)` has to satisfy it, or no `Right_Triangle` could be declared without an
> initial value. It does: 0 = 0 + 0.

> [!NOTE]
> **The same rule, four ways.** This chapter states the Pythagorean theorem as a predicate, a
> precondition, a postcondition and a type invariant. They are not interchangeable, and doing all
> four is the point — by the end you should be able to say which one you would reach for.

Press **Check** when you are done.
