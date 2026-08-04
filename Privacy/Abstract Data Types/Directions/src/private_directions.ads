--  The Records chapter's directions, with Ext_Angle made private.
--
--  The unit is Private_Directions because `Directions` belongs to Records.
package Private_Directions is

   type Angle_Mod is mod 360;

   type Direction is
     (North, Northeast, East, Southeast, South, Southwest, West, Northwest);

   function To_Direction (N : Angle_Mod) return Direction;

   --  Private. Nobody outside can write `(45, Northeast)` and produce an Ext_Angle whose two
   --  halves disagree -- To_Ext_Angle is the only way in, and it works the direction out.
   type Ext_Angle is private;

   function To_Ext_Angle (N : Angle_Mod) return Ext_Angle;

   function Angle_Of (E : Ext_Angle) return Angle_Mod;

   function Direction_Of (E : Ext_Angle) return Direction;

   procedure Display (E : Ext_Angle);

private

   type Ext_Angle is record
      Angle_Elem     : Angle_Mod;
      Direction_Elem : Direction;
   end record;

end Private_Directions;
