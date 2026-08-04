# String operations

A `String` is an array of `Character`. Its operations live in **`Ada.Strings.Fixed`** — "fixed"
because an array has the length it was declared with, and that constraint runs through everything
in this lesson.

## Counting and finding

```adasnippet
S : constant String := "Hello" & 3 * " World";

Cnt := Ada.Strings.Fixed.Count (Source => S, Pattern => P);
Idx := Index (Source => S, Pattern => P, From => Idx + 1);
```

`3 * " World"` is `Ada.Strings.Fixed`'s `"*"` — a string repeated, giving
`Hello World World World`.

`Count` says how many. `Index` finds one, and takes a `From` so the next search can start past the
last hit — which is how you walk all of them.

## Zero means "not there"

```adasnippet
Index (S, "Goodbye")   --  0
```

`Index` returns `Natural`, not `Positive`, precisely so it has a value meaning no. Every search in
this chapter does the same thing, and the check is never optional.

> [!TIP]
> `Count` is a common name — `Ada.Containers` has a `Count_Type`, containers have a `Length`. The
> example qualifies the call as `Ada.Strings.Fixed.Count` for that reason, and it is a habit worth
> keeping when several packages are `use`d at once.

> [!NOTE]
> `Index` has an overload taking a `Character_Set` rather than a pattern, and one taking a
> direction (`Backward`) to search from the end. Both are in the same package.
