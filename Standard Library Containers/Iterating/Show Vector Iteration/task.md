# Iterating

Three ways round a vector. They differ in what the loop variable *is*.

## By element

```adasnippet
for E of V loop
   Put_Line ("- " & Integer'Image (E));
end loop;
```

`E` is a **reference** to the element, not a copy — so this also works:

```adasnippet
for E of V loop
   E := E + 1;      --  modifies the vector
end loop;
```

## By index

```adasnippet
for I in V.First_Index .. V.Last_Index loop
   Put (Integer'Image (V (I)));
end loop;
```

`V (I)` reads like an array subscript and is one. `V.Element (I)` is the long form. `V.I` is not a
thing.

## By cursor

```adasnippet
for C in V.Iterate loop
   Put (Integer'Image (V (C)));
end loop;
```

`Iterate` hands out a cursor per position. `To_Index (C)` says where it is; `Element (C)` gets the
value.

## What the cursor loop is doing

```adasnippet
declare
   C : Cursor := V.First;
begin
   while C /= No_Element loop
      ...
      C := Next (C);
   end loop;
end;
```

`Next` returns `No_Element` at the end. Worth seeing once, and then never writing again.

> [!TIP]
> Use `for E of` unless you need the position. It is the shortest, it cannot go out of range, and
> it says what you mean.

> [!NOTE]
> Accessing an element is required to be O(log N) — not O(1). A vector is not guaranteed to be a
> flat block of memory the way an array is.
