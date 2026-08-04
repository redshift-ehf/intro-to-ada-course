with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Fixed_Versus_Float is
   type Decimal  is delta 10.0 ** (-2) digits 9;
   type Float_32 is digits 6 range -9_999_999.99 .. 9_999_999.99;

   D : Decimal  := 0.01;
   F : Float_32 := 0.01;
begin
   Put_Line ("D = " & Decimal'Image (D));
   Put_Line ("F = " & Float_32'Image (F));

   --  A fixed-point type has no exponent. There is nothing between zero and its delta, so
   --  halving the smallest step does not give a smaller number -- it gives zero. A
   --  floating-point type moves its exponent instead and keeps going.
   D := D / 2;
   F := F / 2.0;

   Put_Line ("after halving, D = " & Decimal'Image (D));
   Put_Line ("after halving, F = " & Float_32'Image (F));
end Show_Fixed_Versus_Float;
