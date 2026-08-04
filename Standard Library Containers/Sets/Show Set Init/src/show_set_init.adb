with Ada.Containers; use Ada.Containers;
with Ada.Containers.Ordered_Sets;

with Ada.Text_IO; use Ada.Text_IO;

--  A set holds each value once. That constraint is the whole type, and it shows up first in the
--  three different ways of putting something in.
procedure Show_Set_Init is

   package Integer_Sets is new
     Ada.Containers.Ordered_Sets
       (Element_Type => Integer);

   use Integer_Sets;

   S   : Set;
   C   : Cursor;
   Ins : Boolean;
begin
   S.Insert (20);
   S.Insert (10);
   S.Insert (0);
   S.Insert (13);

   --  S.Insert (0) here would raise Constraint_Error: 0 is already in. This version says so with
   --  a Boolean instead.
   S.Insert (0, C, Ins);
   if not Ins then
      Put_Line ("Error while inserting 0 into set");
   end if;

   --  Include never complains. Already present means nothing happens.
   S.Include (0);
   S.Include (13);
   S.Include (14);

   Put_Line ("Set has " & Count_Type'Image (S.Length) & " elements");

   --  `for E of` works as it did for vectors -- and an Ordered_Set hands them over in order,
   --  whatever order they went in.
   Put_Line ("Elements:");
   for E of S loop
      Put_Line ("- " & Integer'Image (E));
   end loop;
end Show_Set_Init;
