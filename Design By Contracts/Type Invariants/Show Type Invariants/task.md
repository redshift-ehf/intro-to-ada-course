# Type invariants

A type invariant is a rule a **private** type keeps for its whole life:

```adasnippet
type Account is private
  with Type_Invariant => Check (Account);
```

The `private` is not incidental — it is the entire mechanism. Because callers cannot reach inside,
every way of making or changing an `Account` goes through the package that declared it, and so
every one of them can be checked on the way out.

That is a stronger guarantee than a predicate on a public type, which can be sidestepped by
assigning one component at a time.

## Predicate or invariant?

| | Predicate | Type invariant |
|---|---|---|
| Applies to | any type | private types only |
| Checked on | assignment, parameter passing | values leaving the package |
| Component assignment | escapes the check | impossible from outside |
| Guarantee | "this value is legal here" | "no illegal value can exist" |

Reach for a predicate when a type has legal and illegal values and you want the compiler to say
so. Reach for an invariant when the type is an abstraction whose consistency is the package's
responsibility — which is the same argument that made `Ext_Angle` private in the Privacy chapter,
now enforced rather than merely arranged.

> [!NOTE]
> The invariant is checked as a value **leaves** the package: on return from a function, on an
> `out` parameter, on initialisation. It is not checked inside the package body, which is what
> lets an operation break the rule temporarily while it does its work.

> [!TIP]
> Write the check as a function in the private part, as this example does. It keeps the aspect
> readable and gives you something you can call in a test.

Press **Run**: the overdraft is refused as `Withdraw` returns, so the bad value never reaches the
variable it was going to be assigned to.
