## Exercise: Pythagorean Theorem — Precondition

The same theorem as a **precondition**: a rule about what `Init` may be called with.

```adasnippet
function Init (H, C1, C2 : Length) return Right_Triangle is ((H, C1, C2))
  with Pre => ... ;
```

The record has no predicate this time, so any three numbers are a legal `Right_Triangle`. The
obligation has moved to whoever calls `Init`.

> [!NOTE]
> Compare this with the predicate version. There, an illegal triangle could not exist at all —
> here it can, and only this one route into it is guarded. Assign the components directly and
> nothing objects.

> [!NOTE]
> **The same rule, four ways.** This chapter states the Pythagorean theorem as a predicate, a
> precondition, a postcondition and a type invariant. They are not interchangeable, and doing all
> four is the point — by the end you should be able to say which one you would reach for.

Press **Check** when you are done.
