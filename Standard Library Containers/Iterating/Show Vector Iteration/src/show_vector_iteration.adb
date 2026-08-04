with Ada.Containers.Vectors;

with Ada.Text_IO; use Ada.Text_IO;

--  Three ways round a vector: by element, by index, and by cursor.
procedure Show_Vector_Iteration is

   package Integer_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   use Integer_Vectors;

   function Img (I : Integer) return String renames Integer'Image;

   V : Vector := 20 & 10 & 0 & 13;
begin
   --  1. `for E of` -- E is a reference to the element, not a copy of it.
   Put_Line ("Vector elements are:");
   for E of V loop
      Put_Line ("- " & Img (E));
   end loop;

   --  Which is why this modifies the vector.
   for E of V loop
      E := E + 1;
   end loop;

   --  2. By index, between First_Index and Last_Index. V (I) reads like an array.
   New_Line;
   Put_Line ("After adding one to each, by index:");
   for I in V.First_Index .. V.Last_Index loop
      Put_Line ("- [" & Extended_Index'Image (I) & "] " & Img (V (I)));
   end loop;

   --  3. By cursor, from Iterate. V (C) again -- and To_Index says where C is.
   New_Line;
   Put_Line ("The same, by cursor:");
   for C in V.Iterate loop
      Put_Line ("- [" & Extended_Index'Image (To_Index (C)) & "] " & Img (V (C)));
   end loop;

   --  The long way round, which is what `for C in V.Iterate` is doing underneath: start at
   --  First, call Next, stop at No_Element.
   New_Line;
   Put ("By hand:");
   declare
      C : Cursor := V.First;
   begin
      while C /= No_Element loop
         Put (Img (Element (C)));
         C := Next (C);
      end loop;
   end;
   New_Line;
end Show_Vector_Iteration;
