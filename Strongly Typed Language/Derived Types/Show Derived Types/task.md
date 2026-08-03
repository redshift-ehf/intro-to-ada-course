# Derived types

`type X is new Y` makes a **new type** carrying `Y`'s structure and `Y`'s operations:

```adasnippet
type Position is range 0 .. 1_000;
type Offset   is new Position;
```

`Offset` inherits the lot: `+`, `-`, the comparisons, the literals, the attributes. Nobody declared
any of them for `Offset` and there is no code to write — that is what distinguishes a derivation
from writing out a second, similar-looking type by hand.

What it does not inherit is interchangeability. An `Offset` is not a `Position`, and crossing
between them takes a conversion, exactly as it would between any two types:

```adasnippet
P + Position (O)
```

## Narrowing on the way

A derived type may also constrain the range it inherits:

```adasnippet
type Small_Position is new Position range 0 .. 100;
```

That does two things at once — a new type, *and* a tighter range — which is worth keeping separate
in your head, because the next lesson does only the second of them.
