with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Numerics; use Ada.Numerics;

procedure Show_Ordinary_Fixed_Point is
   --  No `digits`, a `range` instead, and the delta is free of the power-of-ten rule. Here it
   --  is a power of two -- which is what the hardware underneath actually wants.
   type Fraction is delta 2.0 ** (-8) range 0.0 .. 1.0;

   --  The same delta over twice the range.
   type Wide is delta 2.0 ** (-8) range 0.0 .. 2.0;

   --  And a delta that is neither, chosen to suit the problem rather than the machine.
   type Inv_Trig is delta 0.0005 range -Pi / 2.0 .. Pi / 2.0;

   Half : constant Fraction := 0.5;
begin
   --  Fraction was declared up to 1.0 and does not reach it. At this delta the range 0 .. 1.0
   --  is 257 steps, which does not fit in eight bits, so the high bound comes down by one delta
   --  -- RM 3.5.9(13), and GNAT warns about it when it happens.
   Put_Line ("Fraction: asked for 1.0, got " & Fraction'Image (Fraction'Last));

   --  Wide asks for twice as much, needs sixteen bits, and keeps the bound it asked for.
   Put_Line ("Wide:     asked for 2.0, got " & Wide'Image (Wide'Last));

   Put_Line ("both step by " & Fraction'Image (Fraction'Delta));

   Put_Line ("Inv_Trig: delta " & Inv_Trig'Image (Inv_Trig'Delta)
             & " from " & Inv_Trig'Image (Inv_Trig'First)
             & " to " & Inv_Trig'Image (Inv_Trig'Last));

   Put_Line ("half is " & Fraction'Image (Half)
             & " and half of that is " & Fraction'Image (Half / 2));
end Show_Ordinary_Fixed_Point;
