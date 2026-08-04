with Ada.Command_Line;
with Ada.Numerics.Complex_Types; use Ada.Numerics.Complex_Types;
with Ada_Check;
with Rotation;

use Rotation;

procedure Test_Rotation is

   --  The path is trigonometry, so nothing here compares floats exactly.
   Tol : constant Float := 0.001;

   procedure Check_Point (Name : String; C : Complex; Re_Expected, Im_Expected : Float) is
   begin
      Ada_Check.Equal (Name & " (real)", Re (C), Re_Expected, Tolerance => Tol);
      Ada_Check.Equal (Name & " (imaginary)", Im (C), Im_Expected, Tolerance => Tol);
   end Check_Point;
begin
   Ada_Check.Suite ("Rotation");

   --  Four slices: the four axes, and back to the start.
   declare
      P : constant Complex_Points := Positions (4);
   begin
      Ada_Check.Equal ("four slices give five points", P'Length, 5);
      Check_Point ("point 1", P (1),  1.0,  0.0);
      Check_Point ("point 2", P (2),  0.0,  1.0);
      Check_Point ("point 3", P (3), -1.0,  0.0);
      Check_Point ("point 4", P (4),  0.0, -1.0);
      Check_Point ("point 5", P (5),  1.0,  0.0);
   end;

   --  And the same path in degrees. Argument comes back in -180 .. 180, so the fourth is -90
   --  rather than 270.
   declare
      A : constant Angle_Array := To_Angles (Positions (4));
   begin
      Ada_Check.Equal ("angle 1", A (1),    0.0, Tolerance => Tol);
      Ada_Check.Equal ("angle 2", A (2),   90.0, Tolerance => Tol);

      --  A half turn is 180 or -180 -- the same angle, and which one you get depends on which
      --  side of the negative real axis the accumulated rounding leaves the point. cos (Pi/2)
      --  in Float is a small negative number rather than zero, so this path lands just below
      --  the axis and Argument answers -180. The magnitude is the honest assertion.
      Ada_Check.Equal ("angle 3 is a half turn", abs A (3), 180.0, Tolerance => Tol);

      Ada_Check.Equal ("angle 4", A (4),  -90.0, Tolerance => Tol);
      Ada_Check.Equal ("angle 5", A (5),    0.0, Tolerance => Tol);
   end;

   --  Eight slices: 45 degrees each, and the diagonals are 1/sqrt(2).
   declare
      P : constant Complex_Points := Positions (8);
      A : constant Angle_Array    := To_Angles (P);
   begin
      Ada_Check.Equal ("eight slices give nine points", P'Length, 9);
      Check_Point ("point 2 of eight", P (2), 0.7071, 0.7071);
      Ada_Check.Equal ("angle 2 of eight", A (2), 45.0, Tolerance => Tol);
      Ada_Check.Equal ("angle 6 of eight", A (6), -135.0, Tolerance => Tol);
   end;

   --  Twelve slices: 30 degrees each.
   declare
      A : constant Angle_Array := To_Angles (Positions (12));
   begin
      Ada_Check.Equal ("thirteen angles", A'Length, 13);
      Ada_Check.Equal ("angle 2 of twelve", A (2), 30.0, Tolerance => Tol);
      Ada_Check.Equal ("angle 4 of twelve", A (4), 90.0, Tolerance => Tol);
      Ada_Check.Equal ("angle 12 of twelve", A (12), -30.0, Tolerance => Tol);
   end;

   --  Every point is on the unit circle, whatever N is. A rotation changes the argument and
   --  not the modulus, so this fails for anything that scales.
   for N in 1 .. 16 loop
      declare
         P    : constant Complex_Points := Positions (N);
         Good : Boolean := True;
      begin
         for C of P loop
            Good := Good and then abs (abs C - 1.0) < Tol;
         end loop;
         Ada_Check.Check ("all on the unit circle for N =" & Integer'Image (N), Good);
         Ada_Check.Equal ("and there are N + 1 of them for N =" & Integer'Image (N),
                          P'Length, N + 1);
      end;
   end loop;

   --  One slice is a whole turn, so two points, both at the start.
   declare
      P : constant Complex_Points := Positions (1);
   begin
      Check_Point ("one slice, point 1", P (1), 1.0, 0.0);
      Check_Point ("one slice, point 2", P (2), 1.0, 0.0);
   end;

   --  Two slices: there and back.
   declare
      P : constant Complex_Points := Positions (2);
   begin
      Check_Point ("two slices, point 2", P (2), -1.0, 0.0);
      Check_Point ("two slices, point 3", P (3),  1.0, 0.0);
   end;

   --  To_Angles works on any points, not only a rotation's.
   declare
      A : constant Angle_Array :=
        To_Angles ((1 => (1.0, 1.0), 2 => (0.0, -2.0), 3 => (-3.0, 0.0)));
   begin
      Ada_Check.Equal ("45 degrees", A (1), 45.0, Tolerance => Tol);
      Ada_Check.Equal ("-90 degrees", A (2), -90.0, Tolerance => Tol);
      Ada_Check.Equal ("180 degrees", A (3), 180.0, Tolerance => Tol);
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Rotation;
