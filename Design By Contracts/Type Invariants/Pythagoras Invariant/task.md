## Exercise: Pythagorean Theorem — Type Invariant

The same theorem as a **type invariant**: a rule the type keeps for its whole life.

```adasnippet
type Right_Triangle is private
  with Type_Invariant => Check (Right_Triangle);

function Check (T : Right_Triangle) return Boolean;

private

   type Right_Triangle is record
      H      : Length := 0;
      C1, C2 : Length := 0;
   end record;

   function Check (T : Right_Triangle) return Boolean is (...);
```

Fill in `Check`.

> [!NOTE]
> The type is **private**, and that is what makes this the strongest of the four. There is no way
> to build a `Right_Triangle` except through this package, so there is no way for an illegal one
> to exist — not merely no way to pass one somewhere.
>
> It is also why the test reads the components through `H_Of`, `C1_Of` and `C2_Of` rather than
> directly, as it does in the other three.

> [!NOTE]
> **The same rule, four ways.** This chapter states the Pythagorean theorem as a predicate, a
> precondition, a postcondition and a type invariant. They are not interchangeable, and doing all
> four is the point — by the end you should be able to say which one you would reach for.

Press **Check** when you are done.
