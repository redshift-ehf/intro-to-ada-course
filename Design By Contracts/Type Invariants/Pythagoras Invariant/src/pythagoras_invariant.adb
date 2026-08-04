package body Pythagoras_Invariant is

   function Init (H, C1, C2 : Length) return Right_Triangle is
   begin
      return (H, C1, C2);
   end Init;

   function H_Of (T : Right_Triangle) return Length is
   begin
      return T.H;
   end H_Of;

   function C1_Of (T : Right_Triangle) return Length is
   begin
      return T.C1;
   end C1_Of;

   function C2_Of (T : Right_Triangle) return Length is
   begin
      return T.C2;
   end C2_Of;

end Pythagoras_Invariant;
