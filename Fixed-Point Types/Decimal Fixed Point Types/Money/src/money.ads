--  Currency, to the cent, with no rounding error to argue about.
--
--  An original exercise; AdaCore's Laboratories has no Fixed-Point Types chapter.
package Money is

   --  Nine digits, two of them after the point: up to 9_999_999.99.
   type Amount is delta 10.0 ** (-2) digits 9;

   function Add (A, B : Amount) return Amount;

   --  A price times a quantity.
   function Times (A : Amount; Count : Natural) return Amount;

   --  Split evenly, keeping whole cents. Anything left over is dropped.
   function Split (A : Amount; Ways : Positive) return Amount;

   --  What Split drops, so that nothing goes missing.
   function Remainder (A : Amount; Ways : Positive) return Amount;

   --  Without the leading space 'Image insists on.
   function Image (A : Amount) return String;

end Money;
