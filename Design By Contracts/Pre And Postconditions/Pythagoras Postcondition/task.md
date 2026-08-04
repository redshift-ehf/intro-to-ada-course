## Exercise: Pythagorean Theorem — Postcondition

The same theorem as a **postcondition**: a promise about what `Init` returns.

```adasnippet
function Init (H, C1, C2 : Length) return Right_Triangle is ((H, C1, C2))
  with Post => ... ;
```

`Init'Result` is the value being returned; write the theorem about its three components.

> [!NOTE]
> **This one is a poor fit, and noticing that is the exercise.** `Init` does nothing but pass its
> arguments through, so a promise about its result is really a demand on its inputs wearing the
> wrong hat. When it fails, the message blames the implementer for what the caller did.
>
> A postcondition earns its place where the subprogram actually computes something — `Square`, in
> the first lesson, or a sort that promises its output is ordered.

> [!NOTE]
> **The same rule, four ways.** This chapter states the Pythagorean theorem as a predicate, a
> precondition, a postcondition and a type invariant. They are not interchangeable, and doing all
> four is the point — by the end you should be able to say which one you would reach for.

Press **Check** when you are done.
