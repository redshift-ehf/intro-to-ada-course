## Exercise: Shapes

One type, three shapes, each with its own components.

### The type

```adasnippet
type Shape_Kind is (Circle, Rectangle, Triangle);

type Shape (Kind : Shape_Kind) is record
   case Kind is
      when Circle =>
         Radius : Float;
      when Rectangle =>
         Width, Height : Float;
      when Triangle =>
         Base, Vertical : Float;
   end case;
end record;
```

> [!NOTE]
> **Why the triangle's height is called `Vertical`.** Component names must be distinct across the
> whole record, even between variants that can never exist at the same time. `Height` is taken by
> `Rectangle`, so `Triangle` needs another name. This surprises people, and the compiler's message
> is clear when it happens.

### What to write

```adasnippet
function Area (S : Shape) return Float;
function Name (S : Shape) return String;
function Is_Round (S : Shape) return Boolean;
```

| Kind | Area |
|---|---|
| `Circle` | π × radius² |
| `Rectangle` | width × height |
| `Triangle` | ½ × base × vertical |

`Name` returns `"Circle"`, `"Rectangle"` or `"Triangle"`. `Is_Round` is true for exactly one kind.

> [!TIP]
> π is `Ada.Numerics.Pi`. Do not type the digits out.

> [!TIP]
> Write `Area` as a `case` over `S.Kind`. Inside each branch only that variant's components are in
> view, so the compiler will not let you reach for `S.Radius` while handling a rectangle — and
> because a `case` must cover every kind, adding a fourth shape later makes this fail to compile
> rather than fail at run time.

> [!NOTE]
> This exercise is original to this course — see the note in Growable Stack.

Press **Check** when you are done.
