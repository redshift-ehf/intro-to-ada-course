with Ada.Containers; use Ada.Containers;
with Ada.Containers.Ordered_Sets;

with Ada.Text_IO; use Ada.Text_IO;

--  Union, intersection, difference and symmetric difference -- written as operators, not as
--  procedures with names.
procedure Show_Set_Ops is

   package Integer_Sets is new
     Ada.Containers.Ordered_Sets
       (Element_Type => Integer);

   use Integer_Sets;

   procedure Show_Elements (S : Set) is
   begin
      Put ("Elements:");
      for E of S loop
         Put (Integer'Image (E));
      end loop;
      New_Line;
   end Show_Elements;

   procedure Show_Op (S : Set; Op_Name : String) is
   begin
      New_Line;
      Put_Line (Op_Name & "(set #1, set #2) has "
                & Count_Type'Image (S.Length) & " elements");
   end Show_Op;

   S1, S2, S3 : Set;
begin
   S1.Insert (0);
   S1.Insert (10);
   S1.Insert (13);

   S2.Insert (0);
   S2.Insert (10);
   S2.Insert (14);

   S3.Insert (0);
   S3.Insert (10);

   Put_Line ("---- Set #1 ----");
   Show_Elements (S1);
   Put_Line ("---- Set #2 ----");
   Show_Elements (S2);
   Put_Line ("---- Set #3 ----");
   Show_Elements (S3);

   New_Line;
   if S3.Is_Subset (S1) then
      Put_Line ("S3 is a subset of S1");
   else
      Put_Line ("S3 is not a subset of S1");
   end if;

   S3 := S1 and S2;
   Show_Op (S3, "Intersection");
   Show_Elements (S3);

   S3 := S1 or S2;
   Show_Op (S3, "Union");
   Show_Elements (S3);

   S3 := S1 - S2;
   Show_Op (S3, "Difference");
   Show_Elements (S3);

   S3 := S1 xor S2;
   Show_Op (S3, "Symmetric difference");
   Show_Elements (S3);
end Show_Set_Ops;
