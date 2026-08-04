with Ada.Numerics.Complex_Types; use Ada.Numerics.Complex_Types;

--  Rotating a point around the origin, using complex multiplication instead of sines and
--  cosines. Multiplying by a unit complex number *is* a rotation -- the arguments add.
package Rotation is

   type Complex_Points is array (Positive range <>) of Complex;

   subtype Angle is Float;

   type Angle_Array is array (Positive range <>) of Angle;

   --  The N + 1 positions of a point that starts at (1.0, 0.0) and goes once round the origin
   --  in N equal steps. The last one is the first one again.
   --
   --  The labs call this Rotation, like its package. That cannot be called without writing
   --  Rotation.Rotation -- measured -- so it is Positions here.
   function Positions (N : Positive) return Complex_Points;

   --  The same path in degrees, from -180 to 180.
   function To_Angles (C : Complex_Points) return Angle_Array;

end Rotation;
