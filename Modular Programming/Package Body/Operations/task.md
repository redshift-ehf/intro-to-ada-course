## Exercise: Operations

Two packages this time: one with the arithmetic, and a **child** that displays it.

### Operations

Implement the four functions the spec declares.

```adasnippet
function Add      (A, B : Integer) return Integer;
function Subtract (A, B : Integer) return Integer;
function Multiply (A, B : Integer) return Integer;
function Divide   (A, B : Integer) return Integer;
```

`Divide` is integer division, so it truncates: `1 / 2` is `0`, and the tests say so.

### Operations.Test

A child package, in `operations-test.ads` and `operations-test.adb`. Implement `Display`, which
prints all four results for the pair it is given:

```
Operations:
 10 +  5 =  15,
 10 -  5 =  5,
 10 *  5 =  50,
 10 /  5 =  2,
```

The spacing comes from `Integer'Image`, which puts a leading space in front of a non-negative
number. Build each line from `Integer'Image` and the literal text and it will come out right.

> [!NOTE]
> Being a child of `Operations`, this package can call `Add` and the rest **unqualified** and
> without withing its parent. That is the whole point of a child: it is inside the parent's
> declarative region.

Press **Check** when you are done.
