# Unbounded strings

An unbounded string is a bounded one with the bound taken away.

```adasnippet
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

S1, S2 : Unbounded_String;

S1 := To_Unbounded_String ("Hello");
S2 := To_Unbounded_String ("Hello World");
S1 := To_Unbounded_String ("Something longer to say here...");
```

Three things follow from having no maximum:

- **`Ada.Strings.Unbounded` is not generic.** Nothing to instantiate — the bounded version's
  `Max` was the only reason it was.
- **No truncation argument, anywhere.** There is nothing for a string to be too long for.
- **It is on the heap.** With GNAT, bounded strings are on the stack and unbounded ones are not;
  the container handles the allocation and you do not see it.

## The same operations

```adasnippet
Length (S1)
Index (S1, "longer")
Trim (S, Ada.Strings.Both)
Slice (S1, 1, 9)
```

`Ada.Strings.Unbounded` carries the whole of `Ada.Strings.Fixed`'s vocabulary, taking and returning
`Unbounded_String`. Learn the names once.

> [!NOTE]
> "Unbounded" is not literally unbounded — the Reference Manual says the length can vary between 0
> and `Natural'Last`. In practice the limit is memory, and it is not a limit you declare.

> [!TIP]
> `To_String` at the edges. Keep `Unbounded_String` where text is being built or stored, and
> convert to `String` to pass it to a subprogram — a parameter of type `String` accepts anything,
> and one of type `Unbounded_String` accepts only this.
