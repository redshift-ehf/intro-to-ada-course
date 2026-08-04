# Sets

A vector holds whatever you put in it, repeats and all. **A set holds each value once**, and that
one constraint is the whole type.

```adasnippet
package Integer_Sets is new
  Ada.Containers.Ordered_Sets
    (Element_Type => Integer);
```

Note what is missing: no `Index_Type`. A set has no positions to index.

## Three ways to put something in

```adasnippet
S.Insert (20);              --  raises Constraint_Error on a duplicate
S.Insert (0, C, Ins);       --  reports it: Ins is False
S.Include (0);              --  ignores it, silently
```

Which you want depends on what a duplicate means in your program. If it is a bug, `Insert` — let
it raise. If it is expected, `Include`. If you need to know but not to stop, the three-parameter
`Insert`, which also hands back a cursor to the element that is now there.

## Iterating

```adasnippet
for E of S loop
   Put_Line ("- " & Integer'Image (E));
end loop;
```

Exactly as for a vector — and an `Ordered_Set` produces them **in order**, whatever order they
went in.

> [!NOTE]
> `Ada.Containers.Hashed_Sets` is the other kind. Same operations, no ordering, and it needs a
> hash function. Use ordered unless the ordering costs you something you have measured.

> [!TIP]
> "Remove the duplicates and sort it" is one line with a set and a loop with a comparison without
> one. That is the exercise in this lesson.
