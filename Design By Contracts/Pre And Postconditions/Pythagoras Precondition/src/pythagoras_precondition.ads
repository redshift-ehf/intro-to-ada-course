--  The same theorem as a *precondition*: a rule about what Init may be called with.
package Pythagoras_Precondition is

   subtype Length is Natural;

   --  No predicate on the type this time, so any three numbers are a legal value of it.
   type Right_Triangle is record
      H      : Length := 0;
      C1, C2 : Length := 0;
   end record;

   --  The obligation is on the caller instead.
   function Init (H, C1, C2 : Length) return Right_Triangle is ((H, C1, C2))
     with Pre => H * H = C1 * C1 + C2 * C2;

end Pythagoras_Precondition;
