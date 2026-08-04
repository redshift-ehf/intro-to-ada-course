--  The same theorem as a *type invariant*: a rule the type keeps for its whole life.
package Pythagoras_Invariant is

   subtype Length is Natural;

   --  Private, which a type invariant requires. Callers cannot build one directly, so every
   --  route in goes through this package and every route can be checked.
   type Right_Triangle is private
     with Type_Invariant => Check (Right_Triangle);

   function Init (H, C1, C2 : Length) return Right_Triangle;

   function Check (T : Right_Triangle) return Boolean;

   function H_Of (T : Right_Triangle) return Length;
   function C1_Of (T : Right_Triangle) return Length;
   function C2_Of (T : Right_Triangle) return Length;

private

   type Right_Triangle is record
      H      : Length := 0;
      C1, C2 : Length := 0;
   end record;

   function Check (T : Right_Triangle) return Boolean is
     (T.H * T.H = T.C1 * T.C1 + T.C2 * T.C2);

end Pythagoras_Invariant;
