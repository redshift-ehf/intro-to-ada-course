# Elementary functions

```adasnippet
with Ada.Numerics;                      use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

Sqrt (2.0)
Log (X)              --  natural
Log (X, 10.0)        --  to base 10
Cos (Pi)
Arccos (-1.0)
```

`e` and `Pi` are constants in **`Ada.Numerics`** itself, not in `Elementary_Functions` — two
packages, and you usually want both.

## Two things worth knowing

**There is no `Log10`.** A second argument to `Log` is the base, which covers every case with one
name.

**Angles are radians unless you say otherwise.** Every trigonometric function has a form taking a
*cycle*:

```adasnippet
Sin (30.0, 360.0)    --  0.5 -- 30 of a 360-cycle
```

That is better than converting by hand: no `Pi / 180.0` scattered through the code, and the
implementation can reduce the argument exactly.

## Domain errors

```adasnippet
Sqrt (-1.0)          --  raises Argument_Error
```

`Ada.Numerics.Argument_Error`, not `Constraint_Error`. It is what these functions raise when the
argument is outside the mathematical domain.

## The three packages

| | for |
|---|---|
| `Ada.Numerics.Elementary_Functions` | `Float` |
| `Ada.Numerics.Long_Elementary_Functions` | `Long_Float` |
| `Ada.Numerics.Generic_Elementary_Functions` | anything you instantiate it for |

The first is defined as the third, instantiated:

```adasnippet
package Elementary_Functions is new
  Ada.Numerics.Generic_Elementary_Functions (Float);
```

**Every package in this chapter follows that pattern** — a generic, plus ready-made instances for
the predefined types.
