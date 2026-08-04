with Ada.Containers.Vectors;

with Ada.Text_IO; use Ada.Text_IO;

--  Find_Index answers with an index, Find with a cursor. Both have a way of saying "not there",
--  and both of those have to be checked before the answer is used.
procedure Show_Vector_Find is

   package Integer_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   use Integer_Vectors;

   V   : Vector := 20 & 10 & 0 & 13;
   Idx : Extended_Index;
   C   : Cursor;
begin
   Idx := V.Find_Index (10);
   Put_Line ("Index of element with value 10 is " & Extended_Index'Image (Idx));

   C   := V.Find (13);
   Idx := To_Index (C);
   Put_Line ("Index of element with value 13 is " & Extended_Index'Image (Idx));

   --  No_Index and No_Element are the two "not found" answers. Using either without checking
   --  raises Constraint_Error.
   Idx := V.Find_Index (99);
   Put_Line ("99 found: " & Boolean'Image (Idx /= No_Index));

   Idx := V.Find_Index (10);
   if Idx /= No_Index then
      V (Idx) := 11;
   end if;

   C := V.Find (13);
   if C /= No_Element then
      --  V (C) := 14 is the short form; Replace_Element is the long one.
      V.Replace_Element (C, 14);
   end if;

   Put ("Vector is now:");
   for E of V loop
      Put (Integer'Image (E));
   end loop;
   New_Line;
end Show_Vector_Find;
