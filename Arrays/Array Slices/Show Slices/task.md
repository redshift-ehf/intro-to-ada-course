# Array slices

A **slice** is a contiguous run of an array, and is itself an array of the same type:

```adasnippet
Message : constant String := "Hello, World!";

Message (1 .. 5)    --  "Hello"
Message (8 .. 12)   --  "World"
```

Slices are most familiar on `String`, but they work on any one-dimensional array.

## A slice keeps its indices

This catches people out. `Message (8 .. 12)` is five characters long, and its indices are **8 to
12** — it does not start again at 1:

```adasnippet
Message (8 .. 12)'First   --  8, not 1
```

Which is usually what you want: the slice and the array agree about where things are.

## Slices assign

As long as the two are the same length:

```adasnippet
Numbers (1 .. 4) := Numbers (5 .. 8);
```

That is one statement moving four elements, and the lengths are checked. Different lengths raise
`Constraint_Error` — the same rule as assigning a five-character `String` to a ten-character one.

> [!TIP]
> A slice is not a copy when you read it and not a copy when you assign to it. `A (2 .. 4) := ...`
> writes into `A` itself.
