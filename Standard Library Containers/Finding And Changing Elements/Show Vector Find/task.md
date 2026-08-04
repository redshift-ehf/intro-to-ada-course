# Finding and changing elements

```adasnippet
Idx := V.Find_Index (10);   --  an index, or No_Index
C   := V.Find (13);         --  a cursor, or No_Element
```

Both find the **first** match. Both have a value meaning "not there", and both of those have to be
checked before the answer is used — using an invalid index or cursor raises `Constraint_Error`.

```adasnippet
if Idx /= No_Index then
   V (Idx) := 11;
end if;

if C /= No_Element then
   V (C) := 14;             --  or V.Replace_Element (C, 14)
end if;
```

## Which to use

`Find_Index` when you want to do arithmetic with the position. `Find` when you want to hand the
position straight to another operation — `Insert`, `Delete` and `Swap` all take cursors, and
`Find` gives them one without a round trip through an index.

> [!NOTE]
> `Find_Index` returns `Extended_Index`, not `Index_Type`. `No_Index` has to be a value outside
> the ordinary index range, and `Extended_Index` is the type that has room for it — the same
> arrangement as `Natural` and `Integer'First`.

> [!TIP]
> `Update_Element (C, Process'Access)` is a third way to change an element: it calls a procedure
> you supply with the element as an `in out` parameter. Worth knowing for the case where the
> update is more than an assignment.
