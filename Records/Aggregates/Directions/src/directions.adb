with Ada.Text_IO; use Ada.Text_IO;

package body Directions is

   function To_Direction (N : Angle_Mod) return Direction is
   begin
      --  Angle_Mod runs 0 .. 359 and every one of those is covered here, so no `others` branch
      --  is needed and the compiler confirms as much.
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

   procedure Display (N : Ext_Angle) is
   begin
      Put_Line ("Angle: " & Angle_Mod'Image (N.Angle_Elem)
                & " => " & Direction'Image (N.Direction_Elem) & ".");
   end Display;

end Directions;
