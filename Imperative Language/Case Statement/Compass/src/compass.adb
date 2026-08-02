with Ada.Text_IO; use Ada.Text_IO;

procedure Compass is
   --  Change this and press Run again.
   N : constant Integer := 135;
begin
   Put (Integer'Image (N));

   case N is
      when 0 | 360   => Put_Line (" is due north");
      when 1 .. 89   => Put_Line (" is in the northeast quadrant");
      when 90        => Put_Line (" is due east");
      when 91 .. 179 => Put_Line (" is in the southeast quadrant");
      when 180       => Put_Line (" is due south");
      when 181 .. 269 => Put_Line (" is in the southwest quadrant");
      when 270       => Put_Line (" is due west");
      when 271 .. 359 => Put_Line (" is in the northwest quadrant");
      when others    => Put_Line (" is not a compass bearing");
   end case;
end Compass;
