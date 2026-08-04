# Type convention

Two things have to agree at the boundary: what the types *are*, and how they are *laid out*.

## Interfaces.C names C's types

```adasnippet
with Interfaces.C; use Interfaces.C;

A : int;
B : long;
C : unsigned;
D : double;
```

Use these at the boundary, not Ada's own. `int` is C's `int`, whatever width that turns out to be
on this machine. `Integer` is a different type that merely *happens* to match today, on this
target — and the day it does not, nothing will warn you.

## Convention => C lays them out C's way

```adasnippet
type C_Struct is record
   A : int;
   B : long;
   C : unsigned;
   D : double;
end record
  with Convention => C;
```

Without the aspect, Ada may lay a record out however it likes: reorder it, pack it, align it
differently. `Convention => C` says "arrange this the way a C compiler would", which is what makes
it safe to pass as a `struct`.

The same aspect on an enumeration makes its values number the way C's do.

> [!TIP]
> Convert at the boundary and use Ada types everywhere else. A program full of `int` has taken
> C's type system on board along with its functions — see the Generating Bindings lesson for the
> thin layer that stops that spreading.

Press **Run** and compare `int'Size` with `Integer'Size` on this machine.
