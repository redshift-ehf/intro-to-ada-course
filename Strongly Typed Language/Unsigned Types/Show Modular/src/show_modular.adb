with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Modular is
   --  A modular type says how many values it has, not where its bounds are. 2 ** 5 is 32 values,
   --  so the range is 0 .. 31.
   type Mod_Int is mod 2 ** 5;

   A : constant Mod_Int := 20;
   B : constant Mod_Int := 15;

   --  35 does not fit in 0 .. 31, and this does not raise. A modular type wraps instead.
   Sum : constant Mod_Int := A + B;
begin
   Put_Line ("Mod_Int holds" & Integer'Image (Mod_Int'Modulus) & " values,"
             & Mod_Int'Image (Mod_Int'First) & " .." & Mod_Int'Image (Mod_Int'Last));

   Put_Line (Mod_Int'Image (A) & " +" & Mod_Int'Image (B)
             & " wraps round to" & Mod_Int'Image (Sum));

   --  It wraps downwards too, which is the usual reason to reach for one of these.
   Put_Line ("and one below zero is" & Mod_Int'Image (Mod_Int'First - 1));
end Show_Modular;
