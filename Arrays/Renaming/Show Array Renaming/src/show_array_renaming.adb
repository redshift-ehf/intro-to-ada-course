with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Array_Renaming is
   type Integer_Array is array (Positive range <>) of Integer;

   Data : Integer_Array (1 .. 6) := (1, 2, 3, 4, 5, 6);

   --  A slice renames, so Middle is a second name for the middle of Data -- not a copy of it.
   --  It keeps Data's index values too, so its indices are 3 and 4.
   Middle : Integer_Array renames Data (3 .. 4);

   --  A single element renames just as well.
   Head : Integer renames Data (1);
begin
   Middle (3) := 30;
   Middle (4) := 40;
   Head := 100;

   --  Data changed, because there was only ever one array.
   for I in Data'Range loop
      Put (Integer'Image (Data (I)));
   end loop;
   New_Line;

   Put_Line ("Middle runs" & Integer'Image (Middle'First)
             & " .." & Integer'Image (Middle'Last));
end Show_Array_Renaming;
