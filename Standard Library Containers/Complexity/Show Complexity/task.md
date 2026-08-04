# Complexity

The Reference Manual states what each operation must cost. For maps:

| Operations | `Ordered_Maps` | `Hashed_Maps` |
|---|---|---|
| `Insert`, `Include`, `Replace`, `Delete`, `Exclude`, `Find` | O((log N)²) or better | O(log N) |
| anything through a cursor | O(1) | O(1) |

The set table in Set Elements says the same thing. What neither table says is what that means next
to a vector, so this lesson's program measures it.

## How it measures

`"="` and `"<"` are **generic formal parameters**, so an instantiation can supply its own:

```adasnippet
function Counted_Equal (L, R : Integer) return Boolean is
begin
   Vector_Comparisons := Vector_Comparisons + 1;
   return L = R;
end Counted_Equal;

package Integer_Vectors is new
  Ada.Containers.Vectors
    (Index_Type   => Positive,
     Element_Type => Integer,
     "="          => Counted_Equal);
```

The container calls it; the counter goes up. Nothing else changes.

## The answer

Building both with 1024 elements and then searching for the last one:

```
Vector.Find_Index found it: TRUE, after 1024 comparisons
Set.Find found it:          TRUE, after 19 comparisons
```

A vector looks at every element in turn. An ordered set is a tree, so each comparison discards
half of what is left — which is what O(log N) means, in the only terms that matter.

> [!TIP]
> The technique is worth more than the number. Passing an instrumented operator to a generic is
> how you find out what a library is really doing, and it needs no profiler and no special build.

> [!NOTE]
> These are the *Reference Manual's* bounds, not GNAT's. Another compiler may be faster and may
> not be slower. Appendix B of *Introduction to Ada* lists every container in the standard library
> with the same treatment.
