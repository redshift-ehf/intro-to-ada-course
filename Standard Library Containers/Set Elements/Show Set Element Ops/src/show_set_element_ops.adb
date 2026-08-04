with Ada.Containers; use Ada.Containers;
with Ada.Containers.Ordered_Sets;

with Ada.Text_IO; use Ada.Text_IO;

--  Removing and looking up. Each comes in a strict version and a forgiving one, the same
--  distinction Insert and Include drew.
procedure Show_Set_Element_Ops is

   package Integer_Sets is new
     Ada.Containers.Ordered_Sets
       (Element_Type => Integer);

   use Integer_Sets;

   procedure Show_Elements (S : Set) is
   begin
      New_Line;
      Put_Line ("Set has " & Count_Type'Image (S.Length) & " elements");
      Put_Line ("Elements:");
      for E of S loop
         Put_Line ("- " & Integer'Image (E));
      end loop;
   end Show_Elements;

   S : Set;
begin
   S.Insert (20);
   S.Insert (10);
   S.Insert (0);
   S.Insert (13);

   S.Delete (13);

   --  S.Delete (13) again would raise Constraint_Error -- it is gone. Exclude does not mind.
   S.Exclude (13);

   --  Contains answers yes or no.
   if S.Contains (20) then
      Put_Line ("Found element 20 in set");
   end if;

   --  Find answers with a position, so it can also tell you where.
   if S.Find (0) /= No_Element then
      Put_Line ("Found element 0 in set");
   end if;

   Show_Elements (S);
end Show_Set_Element_Ops;
