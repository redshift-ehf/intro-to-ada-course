with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Numerics; use Ada.Numerics;

with Ada.Numerics.Complex_Types;
use  Ada.Numerics.Complex_Types;

with Ada.Numerics.Complex_Elementary_Functions;
use  Ada.Numerics.Complex_Elementary_Functions;

with Ada.Text_IO.Complex_IO;

--  Complex numbers, with the operators you would expect and an I/O package of their own.
procedure Show_Complex_Types is

   --  Complex_IO is generic in the *package* rather than the type -- it needs the whole
   --  instantiation, not just Complex.
   package C_IO is new Ada.Text_IO.Complex_IO (Complex_Types);
   use C_IO;

   X, Y  : Complex;
   R, Th : Float;
begin
   --  Cartesian, as an aggregate: (real, imaginary).
   X := (2.0, -1.0);
   Y := (3.0,  4.0);

   Put (X);
   Put (" * ");
   Put (Y);
   Put (" is ");
   Put (X * Y);
   New_Line;
   New_Line;

   --  Polar, from a modulus and an argument.
   R  := 3.0;
   Th := Pi / 2.0;
   X  := Compose_From_Polar (R, Th);
   --  Or: X := R * Exp ((0.0, Th));
   --  Or: X := R * e ** Complex'(0.0, Th);

   Put_Line ("Polar form:    " & Float'Image (R)
             & " * e**(i * " & Float'Image (Th) & ")");

   --  And back the other way. `abs` is the modulus; Argument is the angle.
   Put ("Modulus     of ");
   Put (X);
   Put (" is " & Float'Image (abs X));
   New_Line;

   Put ("Argument    of ");
   Put (X);
   Put (" is " & Float'Image (Argument (X)));
   New_Line;
   New_Line;

   Put ("Sqrt        of ");
   Put (X);
   Put (" is ");
   Put (Sqrt (X));
   New_Line;

   --  Re and Im read the parts out.
   Put_Line ("Re: " & Float'Image (Re (X)) & "   Im: " & Float'Image (Im (X)));

   --  i is declared in Complex_Types, so the textbook form works as written.
   Put ("1 + 2i squared is ");
   Put ((1.0 + 2.0 * i) ** 2);
   New_Line;
end Show_Complex_Types;
