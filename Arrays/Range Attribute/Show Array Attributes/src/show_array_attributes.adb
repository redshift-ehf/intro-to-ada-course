with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Array_Attributes is
   type My_Int is range 0 .. 1000;
   type My_Int_Array is array (1 .. 5) of My_Int;

   Tab : constant My_Int_Array := (2, 3, 5, 7, 11);
begin
   --  'Range is the whole index range, so the loop cannot disagree with the declaration -- and
   --  changing the array's bounds does not mean hunting for loops to update.
   for I in Tab'Range loop
      Put (My_Int'Image (Tab (I)));
   end loop;
   New_Line;

   --  'First and 'Last when you want only part of it.
   for I in Tab'First .. Tab'Last - 1 loop
      Put (My_Int'Image (Tab (I)));
   end loop;
   New_Line;

   Put_Line ("first" & Integer'Image (Tab'First)
             & ", last" & Integer'Image (Tab'Last)
             & ", length" & Integer'Image (Tab'Length));
end Show_Array_Attributes;
