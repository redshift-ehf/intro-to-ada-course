# First and last elements

Two different things to ask for, and Ada distinguishes them.

```adasnippet
V.First_Element   --  the value at the front
V.Last_Element    --  the value at the back

V.First           --  a *cursor* to the front
V.Last            --  a cursor to the back
```

A **cursor** is a position in a container, not a value in it. `Element (C)` turns one back into a
value.

## Why both exist

```adasnippet
V.Swap (V.First, V.Last);
```

`Swap` moves two elements around, so it needs to know *where* they are — values would not be
enough. That is what cursors are for, and the rest of the chapter uses them for finding,
inserting, deleting and iterating.

> [!TIP]
> A cursor stays valid only as long as the container is not restructured underneath it. Deleting
> through a cursor and then using it again is the classic mistake; the Removing Elements lesson
> shows the loop that avoids it.

> [!NOTE]
> `First_Element` on an empty vector raises `Constraint_Error`. So does `Element (V.First)`, for
> the same reason: `V.First` is `No_Element` and there is nothing there. Check `Is_Empty` first
> when you cannot be sure.
