with Ada.Strings;
with Ada.Strings.Fixed;

package body Money is

   function Add (A, B : Amount) return Amount is
   begin
      return A + B;
   end Add;

   function Times (A : Amount; Count : Natural) return Amount is
   begin
      --  Fixed times integer is that same fixed type, so nothing needs converting here.
      return A * Count;
   end Times;

   function Split (A : Amount; Ways : Positive) return Amount is
   begin
      return A / Ways;
   end Split;

   function Remainder (A : Amount; Ways : Positive) return Amount is
   begin
      return A - Split (A, Ways) * Ways;
   end Remainder;

   function Image (A : Amount) return String is
   begin
      return Ada.Strings.Fixed.Trim (Amount'Image (A), Ada.Strings.Both);
   end Image;

end Money;
