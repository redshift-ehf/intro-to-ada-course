# Removing elements

`Delete` takes an index or a cursor — whichever `Find_Index` or `Find` just gave you.

```adasnippet
Idx := V.Find_Index (10);
if Idx /= No_Index then
   V.Delete (Idx);
end if;
```

## Removing every match

```adasnippet
loop
   I := V.Find_Index (E);
   exit when I = No_Index;
   V.Delete (I);
end loop;
```

Search again after each deletion, and stop when the search comes back empty. It looks wasteful and
it is the right shape: **deleting invalidates positions**, so a position found before a deletion
cannot be trusted after one. The re-search is what keeps this correct.

The same loop with `Find` and `No_Element` deletes by cursor.

> [!NOTE]
> This is why `for C in V.Iterate loop ... V.Delete (C); end loop;` is wrong, however natural it
> looks. The iterator is holding a position the deletion has just moved.

> [!TIP]
> `Is_Empty` rather than `Length = 0`. It says what you are asking, and it does not drag
> `Count_Type` into the expression.
