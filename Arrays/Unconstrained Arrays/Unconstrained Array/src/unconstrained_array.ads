--  The same kind of operations, over an array whose length is not part of its type.
package Unconstrained_Array is

   type My_Array is array (Positive range <>) of Integer;

   --  Fills A with its own length counting down: five elements become 5, 4, 3, 2, 1.
   procedure Init (A : in out My_Array);

   --  Returns a new array of length L, counting down from I.
   function Init (I, L : Positive) return My_Array;

   procedure Double (A : in out My_Array);

   --  Each element replaced by how much it differs from the one before it. The first element
   --  has nothing before it, so it comes back as zero.
   function Diff_Prev_Elem (A : My_Array) return My_Array;

end Unconstrained_Array;
