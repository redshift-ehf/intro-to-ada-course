with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;

with Ada.Text_IO; use Ada.Text_IO;

--  Two ways to reach the ends of a vector: the elements themselves, and cursors to them.
procedure Show_Vector_First_Last is

   package Integer_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   use Integer_Vectors;

   function Img (I : Integer)    return String renames Integer'Image;
   function Img (I : Count_Type) return String renames Count_Type'Image;

   V : Vector := 20 & 10 & 0 & 13;
begin
   Put_Line ("Vector has " & Img (V.Length) & " elements");

   --  First_Element and Last_Element give you the values.
   Put_Line ("First element is " & Img (V.First_Element));
   Put_Line ("Last element is "  & Img (V.Last_Element));

   --  First and Last give you cursors -- positions rather than values. Swap wants positions,
   --  because it has to move two of them.
   V.Swap (V.First, V.Last);

   Put_Line ("First element is now " & Img (V.First_Element));
   Put_Line ("Last element is now "  & Img (V.Last_Element));

   --  A cursor can be turned back into a value with Element.
   Put_Line ("through the cursor: " & Img (Element (V.First)));
end Show_Vector_First_Last;
