with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Numerics; use Ada.Numerics;

with Ada.Numerics.Elementary_Functions;
use  Ada.Numerics.Elementary_Functions;

--  Square roots, logarithms and trigonometry, for Float.
procedure Show_Elem_Math is
   X : Float;
begin
   X := 2.0;
   Put_Line ("Square root of " & Float'Image (X)
             & " is " & Float'Image (Sqrt (X)));

   --  e and Pi are constants in Ada.Numerics itself, not in Elementary_Functions.
   X := e;
   Put_Line ("Natural log of " & Float'Image (X)
             & " is " & Float'Image (Log (X)));

   --  Log with a second argument is the logarithm to that base. There is no separate Log10.
   X := 10.0 ** 6.0;
   Put_Line ("Log_10      of " & Float'Image (X)
             & " is " & Float'Image (Log (X, 10.0)));

   X := 2.0 ** 8.0;
   Put_Line ("Log_2       of " & Float'Image (X)
             & " is " & Float'Image (Log (X, 2.0)));

   --  Angles are in radians unless a cycle is given as a second argument.
   X := Pi;
   Put_Line ("Cos         of " & Float'Image (X)
             & " is " & Float'Image (Cos (X)));

   X := -1.0;
   Put_Line ("Arccos      of " & Float'Image (X)
             & " is " & Float'Image (Arccos (X)));

   --  In degrees, by naming the cycle: 360.0 rather than 2*Pi.
   Put_Line ("Sin (30 degrees) is " & Float'Image (Sin (30.0, 360.0)));

   --  Arguments outside a function's domain raise Argument_Error, not Constraint_Error.
   begin
      Put_Line (Float'Image (Sqrt (-1.0)));
   exception
      when Argument_Error =>
         Put_Line ("Sqrt (-1.0) raises Argument_Error");
   end;
end Show_Elem_Math;
