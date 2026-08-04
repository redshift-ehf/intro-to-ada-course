# Operations on set elements

Removing and looking up. Removing draws the same distinction that `Insert` and `Include` drew:

```adasnippet
S.Delete (13);    --  raises Constraint_Error if it is not there
S.Exclude (13);   --  does not mind
```

## Looking up

```adasnippet
if S.Contains (20) then ...          --  yes or no
if S.Find (0) /= No_Element then ... --  yes or no, and where
```

`Contains` when the answer is all you need — it says so, and it reads better. `Find` when you are
going to do something at that position.

## What it costs

| Operation | `Ordered_Sets` | `Hashed_Sets` |
|---|---|---|
| `Insert`, `Include`, `Replace`, `Delete`, `Exclude`, `Find` | O((log N)²) or better | O(log N) |
| anything through a cursor | O(1) | O(1) |

Both are far better than the O(N) a vector gives you, which is the reason to reach for a set even
when you do not care about uniqueness.

> [!NOTE]
> A set element cannot be modified in place — changing it could break the ordering the set depends
> on. `Replace` deletes and re-inserts, which is the honest description of what has to happen.
