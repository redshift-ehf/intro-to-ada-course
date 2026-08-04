# Private & Limited

Nothing here is new. `private` and `limited` mean what they meant in the Privacy chapter, and
they combine with `tagged` without interacting with it.

```adasnippet
type T is tagged private;              --  extensible, components hidden
type T is tagged limited record ...    --  extensible, cannot be copied
type T is tagged limited private;      --  both
```

| | what it stops |
|---|---|
| `private` | reaching the components from outside |
| `limited` | assignment and predefined equality |

A tagged private type is the ordinary shape for a class whose representation you intend to change.
A tagged limited private type is the shape for one that owns something — a file, a connection, a
lock — where copying would give you two objects that both think they own it.

> [!NOTE]
> A private tagged type can still be extended: by a child package, which sees the full view, or
> anywhere the full view is visible. Privacy limits who may look inside, not who may derive.

> [!TIP]
> The three restrictions are independent and worth choosing separately. `tagged` because it will
> be extended, `private` because the representation is not the contract, `limited` because
> copying would be wrong — each for its own reason, not as a set.
