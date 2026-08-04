--  Compass directions, from an angle in degrees.
package Directions is

   --  Angles wrap: 360 degrees is 0 degrees, which is exactly what a modular type says.
   type Angle_Mod is mod 360;

   type Direction is
     (North, Northeast, East, Southeast, South, Southwest, West, Northwest);

   --  An angle together with the direction it falls in.
   type Ext_Angle is record
      Angle_Elem     : Angle_Mod;
      Direction_Elem : Direction;
   end record;

   function To_Direction (N : Angle_Mod) return Direction;

   function To_Ext_Angle (N : Angle_Mod) return Ext_Angle;

   procedure Display (N : Ext_Angle);

end Directions;
