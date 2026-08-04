with Ada.Numerics; use Ada.Numerics;

package body Rotation is

   function Positions (N : Positive) return Complex_Points is
      --  One step round the circle, as a complex number of modulus 1. Multiplying by it turns a
      --  point by 2*Pi/N radians and leaves its distance from the origin alone.
      Step : constant Complex := Compose_From_Polar (1.0, 2.0 * Pi / Float (N));

      C : Complex_Points (1 .. N + 1);
   begin
      --  Start on the positive real axis, at zero degrees.
      C (1) := Compose_From_Polar (1.0, 0.0);

      for I in 2 .. C'Last loop
         C (I) := C (I - 1) * Step;
      end loop;

      return C;
   end Positions;

   function To_Angles (C : Complex_Points) return Angle_Array is
      A : Angle_Array (C'Range);
   begin
      for I in C'Range loop
         --  Argument gives radians in -Pi .. Pi; this wants degrees.
         A (I) := Argument (C (I)) * 180.0 / Pi;
      end loop;

      return A;
   end To_Angles;

end Rotation;
