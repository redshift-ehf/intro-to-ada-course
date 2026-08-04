# Formal subprograms

A generic may take **subprograms** as formals, declared with `with`:

```adasnippet
generic
   Description : String;
   type T is private;
   with function Comparison (X, Y : T) return Boolean;
procedure Check (X, Y : T);
```

This is the escape hatch from the bargain in Formal Type Declaration. `is private` promises the
body almost nothing — but if the body needs to compare, or add, or print a `T`, the instantiator
can hand that operation over.

The alternative would be narrowing the formal type until the operation comes for free, and that
narrows what may be instantiated. A formal subprogram keeps the type wide and asks for exactly the
one operation needed.

## Operators are functions

```adasnippet
procedure Check_Is_Equal is new
  Check (Description => "equality", T => Integer, Comparison => Standard."=");
```

`"="` and `"<"` are ordinary functions with unusual names, so they can be passed like any other.
`Standard."="` names the predefined equality for `Integer` — the qualification is there because
`"="` may well be overloaded several times over by that point.

> [!TIP]
> A formal subprogram can have a default: `with function Image (E : T) return String is <>;`
> means "use whatever `Image` is visible at the instantiation, unless told otherwise". Handy, and
> worth using sparingly — it resolves to whatever happens to be in scope, which is not always
> what the reader expects.

> [!NOTE]
> This is Ada's answer to what other languages do with interfaces, traits or duck typing. The
> difference is *when*: the requirement is stated in the generic's declaration and checked at
> instantiation, so a missing operation is a compile error at the point of use with a message
> naming the formal it could not fill.
