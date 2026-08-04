with Ada.Containers.Vectors;

with Ada.Text_IO; use Ada.Text_IO;

--  A vector is not a type you can just declare. It comes out of a generic package, which has to
--  be instantiated first -- and that instantiation is where the element type is chosen.
procedure Show_Vector_Inst is

   package Integer_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   --  Only now does the type exist, and it belongs to the instance.
   V : Integer_Vectors.Vector;

   --  A second instance is a second, unrelated type. Nothing assigns between them.
   package Float_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Positive,
        Element_Type => Float);

   W : Float_Vectors.Vector;
begin
   Put_Line ("V is empty: " & Boolean'Image (V.Is_Empty));
   Put_Line ("W is empty: " & Boolean'Image (W.Is_Empty));

   --  Index_Type decides where the first element sits. Natural starts at 0, Positive at 1.
   V.Append (7);
   W.Append (7.0);
   Put_Line ("first index of V: " & Natural'Image (V.First_Index));
   Put_Line ("first index of W: " & Positive'Image (W.First_Index));
end Show_Vector_Inst;
