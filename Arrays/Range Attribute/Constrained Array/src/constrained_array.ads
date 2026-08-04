--  An array whose bounds are part of its type, and some operations over it.
package Constrained_Array is

   type My_Index is range 1 .. 10;

   type My_Array is array (My_Index) of Integer;

   --  Every My_Array is ten elements long. The bounds are in the type, so no function here has
   --  to be told how big its argument is.
   function Init return My_Array;

   procedure Double (A : in out My_Array);

   function First_Elem (A : My_Array) return Integer;

   function Last_Elem (A : My_Array) return Integer;

   function Length (A : My_Array) return Integer;

end Constrained_Array;
