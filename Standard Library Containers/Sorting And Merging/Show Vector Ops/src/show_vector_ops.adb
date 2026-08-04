with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;

with Ada.Text_IO; use Ada.Text_IO;

--  Operations on the vector as a whole: concatenation, and -- from a second instantiation --
--  sorting and merging.
procedure Show_Vector_Ops is

   package Integer_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   --  Generic_Sorting is a child of the *instance*, so it is instantiated as a child of
   --  Integer_Vectors and not of Ada.Containers.Vectors.
   package Integer_Vectors_Sorting is
     new Integer_Vectors.Generic_Sorting;

   use Integer_Vectors;
   use Integer_Vectors_Sorting;

   procedure Show_Elements (Name : String; V : Vector) is
   begin
      Put (Name & " (" & Count_Type'Image (V.Length) & " ):");
      for E of V loop
         Put (Integer'Image (E));
      end loop;
      New_Line;
   end Show_Elements;

   V, V1, V2, V3 : Vector;
begin
   V1 := 10 & 12 & 18;
   V2 := 11 & 13 & 19;
   V3 := 15 & 19;

   Show_Elements ("V1", V1);
   Show_Elements ("V2", V2);
   Show_Elements ("V3", V3);

   New_Line;
   Put_Line ("Concatenating V1, V2 and V3 into V:");
   V := V1 & V2 & V3;
   Show_Elements ("V ", V);

   New_Line;
   Put_Line ("Sorting V:");
   Sort (V);
   Show_Elements ("V ", V);

   New_Line;
   Put_Line ("Merging V2 into V1:");
   --  Merge assumes both are already sorted, and empties V2 into V1.
   Merge (V1, V2);
   Show_Elements ("V1", V1);
   Show_Elements ("V2", V2);

   Put_Line ("Is V sorted? " & Boolean'Image (Is_Sorted (V)));
end Show_Vector_Ops;
