with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Slices is
   Message : constant String := "Hello, World!";

   type Integer_Array is array (Positive range <>) of Integer;
   Numbers : Integer_Array (1 .. 8) := (1, 2, 3, 4, 5, 6, 7, 8);
begin
   --  A slice is a contiguous run of an array, and is itself an array of the same type.
   Put_Line (Message (1 .. 5));
   Put_Line (Message (8 .. 12));

   --  A slice keeps the index values it had rather than starting again at one. This one runs
   --  8 .. 12, which is worth knowing before you index into it.
   Put_Line ("that slice runs" & Integer'Image (Message (8 .. 12)'First)
             & " .." & Integer'Image (Message (8 .. 12)'Last));

   --  Slices assign, as long as the two are the same length.
   Numbers (1 .. 4) := Numbers (5 .. 8);
   for I in Numbers'Range loop
      Put (Integer'Image (Numbers (I)));
   end loop;
   New_Line;
end Show_Slices;
