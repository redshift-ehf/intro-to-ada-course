--  A price cannot be negative -- said with a predicate rather than a range.
package Price_Range is

   type Amount is delta 10.0 ** (-2) digits 12;

   --  The obvious way is `subtype Price is Amount range 0.0 .. Amount'Last;`. This says the
   --  same thing a different way, and the difference shows in what is raised: a range gives
   --  Constraint_Error, a predicate gives Assertion_Error.
   subtype Price is Amount
     with Dynamic_Predicate => Price >= 0.0;

   function Total (Unit : Price; Count : Natural) return Price;

end Price_Range;
