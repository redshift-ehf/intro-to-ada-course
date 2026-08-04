with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Indexing is
   type My_Int is range 0 .. 1000;
   type My_Index is range 1 .. 5;

   type My_Int_Array is array (My_Index) of My_Int;

   Tab : constant My_Int_Array := (2, 3, 5, 7, 11);
begin
   --  The index is type-checked like anything else. A second index type with the identical
   --  range 1 .. 5 would still be rejected here -- see the task description.
   for I in My_Index loop
      Put (My_Int'Image (Tab (I)));
   end loop;
   New_Line;

   --  And the bounds are checked as the program runs. Reading past the end raises
   --  Constraint_Error rather than handing back whatever happened to be in memory next.
   Put_Line ("Tab runs" & My_Index'Image (Tab'First)
             & " .." & My_Index'Image (Tab'Last));
end Show_Indexing;
