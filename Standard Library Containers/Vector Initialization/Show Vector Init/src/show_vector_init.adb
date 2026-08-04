with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;

with Ada.Text_IO; use Ada.Text_IO;

--  A vector can be given its elements in its own declaration, with "&".
procedure Show_Vector_Init is

   package Integer_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   --  With `use`, the instance's types and operations are directly visible.
   use Integer_Vectors;

   V : constant Vector := 20 & 10 & 0 & 13;

   --  "&" also joins whole vectors, which is why this reads the same as a concatenation.
   W : constant Vector := V & (1 & 2);
begin
   Put_Line ("Vector has "
             & Count_Type'Image (V.Length)
             & " elements");

   --  Length returns Count_Type, not Integer. It counts elements, so it cannot be negative.
   Put_Line ("W has "
             & Count_Type'Image (W.Length)
             & " elements");

   --  Vector is tagged, so V.Length and Length (V) are the same call.
   Put_Line ("and the same, written the other way: "
             & Count_Type'Image (Length (V)));
end Show_Vector_Init;
