with Ada.Text_IO; use Ada.Text_IO;

procedure Swap is

   --  `in out` is read and written throughout. This is the classic use for it.
   procedure Exchange (A, B : in out Integer) is
      Tmp : Integer;
   begin
      Tmp := A;
      A   := B;
      B   := Tmp;
   end Exchange;

   --  `out` is written by the subprogram and read by the caller afterwards. It is how a procedure
   --  returns something without being a function.
   procedure Halve (Value : Integer; Result : out Integer) is
   begin
      Result := Value / 2;
   end Halve;

   --  `in` is the default and is read-only. Assigning to Value here would not compile, which is
   --  the point: the mode is checked, not merely documented.
   procedure Report (Value : Integer) is
   begin
      Put_Line ("Value is" & Integer'Image (Value));
   end Report;

   X : Integer := 12;
   Y : Integer := 44;
   Z : Integer;

begin
   Put_Line ("Before: X =" & Integer'Image (X) & ", Y =" & Integer'Image (Y));
   Exchange (X, Y);
   Put_Line ("After:  X =" & Integer'Image (X) & ", Y =" & Integer'Image (Y));

   Halve (X, Z);
   Report (Z);
end Swap;
