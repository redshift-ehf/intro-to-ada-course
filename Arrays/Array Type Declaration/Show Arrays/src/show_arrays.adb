with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Arrays is
   type My_Int is range 0 .. 1000;
   type Index  is range 1 .. 5;

   --  An array type is declared by its index type and its element type. Nowhere do you write a
   --  size: the size follows from the range of the index.
   type My_Int_Array is array (Index) of My_Int;

   --  An array value is written as an aggregate, exactly as a record value is.
   Arr : constant My_Int_Array := (2, 3, 5, 7, 11);

   --  Any discrete type may index an array, enumerations included -- which is often the point.
   type Day is (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);
   type Workload is array (Day) of Natural;

   Hours : constant Workload := (Monday .. Friday => 8, Saturday | Sunday => 0);
begin
   for I in Index loop
      --  Indexing looks exactly like a function call, and that is not a coincidence: from the
      --  caller's side an array and a function of one argument are the same shape.
      Put (My_Int'Image (Arr (I)));
   end loop;
   New_Line;

   for D in Day loop
      Put_Line (Day'Image (D) & ":" & Natural'Image (Hours (D)));
   end loop;
end Show_Arrays;
