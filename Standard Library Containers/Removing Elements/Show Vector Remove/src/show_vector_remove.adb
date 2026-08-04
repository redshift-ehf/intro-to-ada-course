with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;

with Ada.Text_IO; use Ada.Text_IO;

--  Delete takes an index or a cursor. To remove every match, search again after each deletion
--  until the search comes back empty.
procedure Show_Vector_Remove is

   package Integer_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   use Integer_Vectors;

   procedure Show_Elements (V : Vector) is
   begin
      New_Line;
      Put_Line ("Vector has " & Count_Type'Image (V.Length) & " elements");

      if not V.Is_Empty then
         Put ("Vector elements are:");
         for E of V loop
            Put (Integer'Image (E));
         end loop;
         New_Line;
      end if;
   end Show_Elements;

   V : Vector := 20 & 10 & 0 & 13 & 10 & 14 & 13;
begin
   Show_Elements (V);

   --  Every 10, found by index.
   declare
      E : constant Integer := 10;
      I : Extended_Index;
   begin
      New_Line;
      Put_Line ("Removing all elements with value of " & Integer'Image (E) & "...");
      loop
         I := V.Find_Index (E);
         exit when I = No_Index;
         V.Delete (I);
      end loop;
   end;

   --  Every 13, found by cursor. Same shape, different "not found" value.
   declare
      E : constant Integer := 13;
      C : Cursor;
   begin
      Put_Line ("Removing all elements with value of " & Integer'Image (E) & "...");
      loop
         C := V.Find (E);
         exit when C = No_Element;
         V.Delete (C);
      end loop;
   end;

   Show_Elements (V);
end Show_Vector_Remove;
