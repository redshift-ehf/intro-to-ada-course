with Ada.Text_IO; use Ada.Text_IO;

procedure Check_Direction is
   --  Change this and press Run again.
   N : constant Integer := 45;
begin
   Put (Integer'Image (N));

   if N = 0 or N = 360 then
      Put_Line (" is due north");
   elsif N in 1 .. 89 then
      Put_Line (" is in the northeast quadrant");
   elsif N = 90 then
      Put_Line (" is due east");
   elsif N in 91 .. 179 then
      Put_Line (" is in the southeast quadrant");
   elsif N = 180 then
      Put_Line (" is due south");
   else
      Put_Line (" is somewhere in the west");
   end if;
end Check_Direction;
