with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Simple_Bounds is
   type My_Int is range 0 .. 1000;

   --  No named index type this time. Writing the range directly creates an anonymous subtype of
   --  Integer, which is what indexes the array.
   type My_Int_Array is array (1 .. 5) of My_Int;

   Tab : constant My_Int_Array := (2, 3, 5, 7, 11);
begin
   --  So the loop variable is an Integer, and 1 .. 5 works without any conversion.
   for I in 1 .. 5 loop
      Put (My_Int'Image (Tab (I)));
   end loop;
   New_Line;
end Show_Simple_Bounds;
