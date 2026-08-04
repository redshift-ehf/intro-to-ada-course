package body Boxes is

   function Make (Value : Integer) return Int_Box is
   begin
      return new Integer'(Value);
   end Make;

   function Get (B : Int_Box) return Integer is
   begin
      return B.all;
   end Get;

   procedure Set (B : Int_Box; Value : Integer) is
   begin
      B.all := Value;
   end Set;

   function Is_Empty (B : Int_Box) return Boolean is
   begin
      return B = null;
   end Is_Empty;

   procedure Swap (A, B : Int_Box) is
      Temp : constant Integer := A.all;
   begin
      --  The contents are exchanged. Assigning A := B instead would exchange nothing -- it would
      --  point both names at one Integer and lose the other.
      A.all := B.all;
      B.all := Temp;
   end Swap;

end Boxes;
