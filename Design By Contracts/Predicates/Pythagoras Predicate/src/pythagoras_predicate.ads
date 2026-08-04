--  The Pythagorean theorem as a *predicate*: a rule about which values of the type are legal.
package Pythagoras_Predicate is

   subtype Length is Natural;

   --  Checked whenever a whole Right_Triangle is assigned or passed. Note it names the type
   --  itself to reach the components -- that is how a predicate refers to the value at hand.
   type Right_Triangle is record
      H      : Length := 0;
      C1, C2 : Length := 0;
   end record
     with Dynamic_Predicate =>
       Right_Triangle.H * Right_Triangle.H
         = Right_Triangle.C1 * Right_Triangle.C1
         + Right_Triangle.C2 * Right_Triangle.C2;

   function Init (H, C1, C2 : Length) return Right_Triangle is ((H, C1, C2));

end Pythagoras_Predicate;
