# Subtypes

A **subtype** is not a new type. It is the same type, with a constraint attached:

```adasnippet
type Position is range 0 .. 1_000;
subtype Near is Position range 0 .. 100;
```

A `Near` *is* a `Position`. Assignment works in both directions with no conversion written
anywhere:

```adasnippet
P : Position := 50;
N : Near     := 50;
begin
   P := N;   --  always fine
   N := P;   --  fine while P is in 0 .. 100, Constraint_Error otherwise
```

The constraint is perfectly real. It is simply checked as the value goes in, at run time, rather
than standing as a compile-time barrier between two different types.

## So which one?

| | `type D is new P range 10 .. 50` | `subtype S is P range 10 .. 50` |
|---|---|---|
| Is it a new type? | yes | no — it is `P` |
| Assigning to or from a `P` | needs a conversion | needs nothing |
| A value outside 10 .. 50 | `Constraint_Error` | `Constraint_Error` |
| Using one where a `P` is meant | will not compile | compiles; it *is* a `P` |

Reach for a subtype to say "a `Position`, but a small one". Reach for a derived type when you want
the compiler to stop you mixing two things up — which is the distinction the exercise after this
one is built around.

## Subtypes as type aliases

With no constraint at all, a subtype is simply another name for the type:

```adasnippet
subtype Distance is Position;
```

> [!NOTE]
> You have been using these since the first chapter without knowing it. `Natural` and `Positive`
> are declared in `Standard` as nothing more than subtypes of `Integer` — `Integer range 0 ..
> Integer'Last` and `Integer range 1 .. Integer'Last`.
