# Set operations

Union, intersection, difference and symmetric difference. Ada writes them as **operators**:

| Set operation | Operator |
|---|---|
| Union | `or` |
| Intersection | `and` |
| Difference | `-` |
| Symmetric difference | `xor` |

```adasnippet
S3 := S1 and S2;   --  in both
S3 := S1 or  S2;   --  in either
S3 := S1  -  S2;   --  in S1 and not S2
S3 := S1 xor S2;   --  in exactly one
```

Compare `Merge (V1, V2)` from the vectors half of this chapter: a procedure, modifying its first
argument, leaving the second empty. These are functions returning a new set, and they compose:
`(S1 or S2) - S3` is one expression.

## And the relations

```adasnippet
if S3.Is_Subset (S1) then ...
```

`Overlap (S1, S2)` is the other one — true when the intersection is non-empty, without building
it.

> [!NOTE]
> `and`, `or` and `xor` on sets are the same operators as on `Boolean`, overloaded. That is not a
> pun: a set *is* a predicate over its element type, and the two meanings agree exactly.

> [!TIP]
> `S1 - S2` where both are large is cheaper than looping and calling `Exclude`, and much cheaper
> than looping and calling `Delete` inside a check.
