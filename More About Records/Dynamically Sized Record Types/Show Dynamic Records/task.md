# Dynamically sized record types

A record's size does not have to be known when the program is compiled.

```adasnippet
Max_Len : constant Natural := Compute_Max_Len;

type Growable_Stack is record
   Items : Items_Array (1 .. Max_Len);
   Len   : Natural := 0;
end record;
```

`Compute_Max_Len` runs when the program starts. Until it does, nobody — including the compiler —
knows how big a `Growable_Stack` is.

## But they are all the same size

This is the limit of what this buys you. `Max_Len` is settled once, when the declaration is
elaborated, and every `Growable_Stack` in the run is that size. You can decide the size at
startup; you cannot have a big one and a small one.

That is what the next lesson is for.

> [!NOTE]
> The type is still **definite** — objects of it need no extra information to be declared, because
> the size, whatever it turned out to be, is the same for all of them. Contrast an unconstrained
> array type, where each object carries its own bounds.

Press **Run** and note that both stacks report the same length.
