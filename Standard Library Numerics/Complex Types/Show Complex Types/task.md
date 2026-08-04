# Complex types

```adasnippet
with Ada.Numerics.Complex_Types;                use Ada.Numerics.Complex_Types;
with Ada.Numerics.Complex_Elementary_Functions; use Ada.Numerics.Complex_Elementary_Functions;

X : Complex := (2.0, -1.0);      --  (real, imaginary)
Y : Complex := (3.0,  4.0);

X * Y
```

Every operator you would expect is there, so complex arithmetic reads like arithmetic. `Re (X)` and
`Im (X)` read the parts out, and `i` is declared in the package, so `1.0 + 2.0 * i` works as
written.

## Cartesian and polar

```adasnippet
X := Compose_From_Polar (R, Th);
--  or: R * Exp ((0.0, Th))
--  or: R * e ** Complex'(0.0, Th)

abs X          --  the modulus
Argument (X)   --  the angle, in radians, from -Pi to Pi
```

`abs` on a complex number is its distance from the origin. `Argument` is the angle back — and its
range is `-Pi .. Pi`, so three quarters of a turn comes back as **-90 degrees, not 270**.

## Complex_IO

```adasnippet
package C_IO is new Ada.Text_IO.Complex_IO (Complex_Types);
```

Generic in the **package**, not the type — it needs the whole instantiation. Then `Put (X)` prints
`( 2.00000E+00,-1.00000E+00)`.

> [!NOTE]
> Compose a point at exactly 90 degrees and read `Re` back and you get `-1.31E-07`, not zero:
> `cos (Pi/2)` in `Float` is a small negative number, because `Pi/2` in `Float` is not exactly a
> quarter turn. Nothing is wrong; this is what floating point is. It matters in the exercise.

> [!TIP]
> Multiplying by a complex number of modulus 1 **is** a rotation — the arguments add and the
> moduli multiply. That is the whole trick this lesson's exercise is built on, and it is why
> computer graphics reaches for complex numbers.
