package body C_Statistics is

   --  `use type` rather than a plain `use`: it makes Interfaces.C's operators visible -- the
   --  `+` and `/` below -- without bringing in every name in the package. Without it, C_Int is
   --  visible and has no arithmetic, and GNAT says "there is no applicable operator +".
   use type Interfaces.C.int;

   function Mean (A, B : C_Int) return C_Int is
   begin
      return (A + B) / 2;
   end Mean;

   procedure Reset is
   begin
      Call_Count := 0;
   end Reset;

end C_Statistics;
