with Ada.Command_Line;
with Ada_Check;
with Temperatures;

procedure Test_Temperatures is

   --  To_Celsius is overloaded on Int_Celsius and Kelvin, so every call below says which it
   --  means with a qualified expression -- `Int_Celsius'(0)` rather than a bare 0.
   use Temperatures;
begin
   Ada_Check.Suite ("Temperatures");

   Ada_Check.Equal ("0 C from an integer",
                    Float (To_Celsius (Int_Celsius'(0))), 0.0);
   Ada_Check.Equal ("100 C from an integer",
                    Float (To_Celsius (Int_Celsius'(100))), 100.0);
   Ada_Check.Equal ("-273 C from an integer",
                    Float (To_Celsius (Int_Celsius'(-273))), -273.0);

   --  Int_Celsius goes one degree higher than Celsius does, so this one has to saturate.
   Ada_Check.Equal ("5505 saturates at the top of Celsius",
                    Float (To_Celsius (Int_Celsius'(5505))), 5504.85,
                    Tolerance => 0.01);

   Ada_Check.Equal ("0.0 C to an integer",
                    Integer (To_Int_Celsius (Celsius'(0.0))), 0);
   Ada_Check.Equal ("25.4 C rounds down to 25",
                    Integer (To_Int_Celsius (Celsius'(25.4))), 25);
   Ada_Check.Equal ("25.6 C rounds up to 26",
                    Integer (To_Int_Celsius (Celsius'(25.6))), 26);
   --  Celsius'First, not the literal -273.15. `digits 6` rounds the declared bound to a machine
   --  value, and the exact decimal then sits a fraction outside the type -- GNAT rejects
   --  `Celsius'(-273.15)` at compile time with "static expression fails Constraint_Check". The
   --  attribute is the bound, whatever it rounded to, so it is always in range.
   Ada_Check.Equal ("the bottom of the scale rounds to -273",
                    Integer (To_Int_Celsius (Celsius'First)), -273);

   Ada_Check.Equal ("273.15 K is 0 C",
                    Float (To_Celsius (Kelvin'(273.15))), 0.0);
   Ada_Check.Equal ("0 K is absolute zero",
                    Float (To_Celsius (Kelvin'(0.0))), -273.15);
   Ada_Check.Equal ("0 C is 273.15 K",
                    Float (To_Kelvin (Celsius'(0.0))), 273.15);
   Ada_Check.Equal ("absolute zero is 0 K",
                    Float (To_Kelvin (Celsius'First)), 0.0);

   --  Out and back again. This is the assertion that catches a sign error in one direction
   --  only, which the individual checks above can miss if both are wrong the same way.
   Ada_Check.Equal ("21.5 C survives a round trip through Kelvin",
                    Float (To_Celsius (To_Kelvin (Celsius'(21.5)))), 21.5);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Temperatures;
