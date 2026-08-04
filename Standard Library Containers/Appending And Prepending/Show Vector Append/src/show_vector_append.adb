with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;

with Ada.Text_IO; use Ada.Text_IO;

--  Append puts an element at the end, Prepend at the beginning. Neither needs to be told how
--  much room to make -- that is the whole difference from an array.
procedure Show_Vector_Append is

   package Integer_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   use Integer_Vectors;

   V : Vector;
begin
   Put_Line ("Appending some elements to the vector...");
   V.Append (20);
   V.Append (10);
   V.Append (0);
   V.Append (13);
   Put_Line ("Finished appending.");

   Put_Line ("Prepending some elements to the vector...");
   V.Prepend (30);
   V.Prepend (40);
   V.Prepend (100);
   Put_Line ("Finished prepending.");

   Put_Line ("Vector has "
             & Count_Type'Image (V.Length)
             & " elements");

   --  Each Prepend pushed everything already there along by one, which is why the order comes
   --  out reversed relative to the calls.
   Put ("Order:");
   for E of V loop
      Put (Integer'Image (E));
   end loop;
   New_Line;
end Show_Vector_Append;
