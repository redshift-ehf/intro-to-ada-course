# Strong typing

Two types can be built out of the same thing and still have nothing to do with each other:

```adasnippet
type Meters is new Float;
type Feet   is new Float;
```

Both are `Float` underneath. The compiler does not care:

```adasnippet
Height : constant Meters := 100.0;
Wrong  : constant Feet   := Height;   --  expected type Feet, found type Meters
```

That is the entire idea. The unit is the reason the two types exist, so confusing them is exactly
the mistake worth catching — and it is caught before the program runs, every time, for nothing.

Converting is explicit, and says what it is doing:

```adasnippet
function To_Feet (M : Meters) return Feet is
  (Feet (Float (M) * 3.280_84));
```

> [!NOTE]
> **In other languages**
>
> C converts between numeric types for you, silently, in almost any expression. That is convenient
> right up until the day it is not, and the day it is not tends to be expensive. Ada makes you
> write the conversion out: a few more characters, in exchange for knowing that every conversion
> in the program is one somebody meant.

> [!TIP]
> Add the `Wrong` line to the file and press **Run** to read the error for yourself.
