with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Floats is
   --  `digits` is a promise about precision: at least this many decimal digits are carried. It
   --  is a requirement the compiler must meet, not a description of the hardware.
   type Precise is digits 12;

   --  A floating-point type can carry a range as well, and the range is checked.
   type Fraction is digits 6 range -1.0 .. 1.0;

   X : constant Float    := 2.5;
   F : constant Fraction := 0.5;

   Third_Float   : constant Float   := Float (1) / Float (3);
   Third_Precise : constant Precise := Precise (1) / Precise (3);
begin
   Put_Line ("abs (-2.5) is " & Float'Image (abs (-X)));
   Put_Line ("2.5 ** 2   is " & Float'Image (X ** 2));

   --  The same division, at two precisions. Count the digits before they stop agreeing.
   Put_Line ("Float   carries" & Integer'Image (Float'Digits) & " digits: "
             & Float'Image (Third_Float));
   Put_Line ("Precise carries" & Integer'Image (Precise'Digits) & " digits: "
             & Precise'Image (Third_Precise));

   --  'Image puts a space in front of a non-negative number and a minus in front of a negative
   --  one, so the space before Fraction'First is written out and the others are not.
   Put_Line ("Fraction runs " & Fraction'Image (Fraction'First)
             & " .." & Fraction'Image (Fraction'Last)
             & " and holds" & Fraction'Image (F));
end Show_Floats;
