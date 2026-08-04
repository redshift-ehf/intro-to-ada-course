with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Decimal_Fixed_Point is
   --  Two numbers make the type. `delta` is how fine the steps are; `digits` is how many
   --  decimal digits there are altogether, which together fix the range.
   type Tenths is delta 10.0 ** (-1) digits 3;   --  steps of 0.1
   type Units  is delta 10.0 ** (0)  digits 3;   --  steps of 1
   type Cents  is delta 10.0 ** (-2) digits 3;   --  steps of 0.01
begin
   Put_Line ("Tenths: delta " & Tenths'Image (Tenths'Delta)
             & " from " & Tenths'Image (Tenths'First)
             & " to " & Tenths'Image (Tenths'Last));
   Put_Line ("Units:  delta " & Units'Image (Units'Delta)
             & " from " & Units'Image (Units'First)
             & " to " & Units'Image (Units'Last));
   Put_Line ("Cents:  delta " & Cents'Image (Cents'Delta)
             & " from " & Cents'Image (Cents'First)
             & " to " & Cents'Image (Cents'Last));

   --  Three digits is three digits in every case. Where the point sits is what `delta` moves,
   --  and moving it right costs range at the same rate as it buys precision.
end Show_Decimal_Fixed_Point;
