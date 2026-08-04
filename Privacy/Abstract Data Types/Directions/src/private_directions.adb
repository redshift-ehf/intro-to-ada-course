with Ada.Text_IO; use Ada.Text_IO;

package body Private_Directions is

   function To_Direction (N : Angle_Mod) return Direction is
   begin
      case N is
         when 0          => return North;
         when 1 .. 89    => return Northeast;
         when 90         => return East;
         when 91 .. 179  => return Southeast;
         when 180        => return South;
         when 181 .. 269 => return Southwest;
         when 270        => return West;
         when 271 .. 359 => return Northwest;
      end case;
   end To_Direction;

   function To_Ext_Angle (N : Angle_Mod) return Ext_Angle is
   begin
      return (Angle_Elem => N, Direction_Elem => To_Direction (N));
   end To_Ext_Angle;

   function Angle_Of (E : Ext_Angle) return Angle_Mod is
   begin
      return E.Angle_Elem;
   end Angle_Of;

   function Direction_Of (E : Ext_Angle) return Direction is
   begin
      return E.Direction_Elem;
   end Direction_Of;

   procedure Display (E : Ext_Angle) is
   begin
      Put_Line ("Angle: " & Angle_Mod'Image (E.Angle_Elem)
                & " => " & Direction'Image (E.Direction_Elem) & ".");
   end Display;

end Private_Directions;
