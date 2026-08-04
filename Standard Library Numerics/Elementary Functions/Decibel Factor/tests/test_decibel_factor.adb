with Ada.Command_Line;
with Ada_Check;
with Decibel_Factor;

procedure Test_Decibel_Factor is
   use Decibel_Factor;
begin
   Ada_Check.Suite ("Decibel factor");

   --  The lab's own six cases, to the two decimal places it prints.
   Ada_Check.Equal ("3 dB is about 1.41", To_Factor (3.0), 1.41, Tolerance => 0.005);
   Ada_Check.Equal ("6 dB is about 2.00", To_Factor (6.0), 2.00, Tolerance => 0.005);
   Ada_Check.Equal ("20 dB is 10", To_Factor (20.0), 10.00, Tolerance => 0.005);

   Ada_Check.Equal ("a factor of 2 is 6.02 dB", To_Decibel (2.0), 6.02, Tolerance => 0.005);
   Ada_Check.Equal ("a factor of 4 is 12.04 dB", To_Decibel (4.0), 12.04, Tolerance => 0.005);
   Ada_Check.Equal ("a factor of 100 is 40 dB", To_Decibel (100.0), 40.00, Tolerance => 0.005);

   --  A ratio of 1 is no change at all, which is 0 dB. The one value both directions must fix.
   Ada_Check.Equal ("a factor of 1 is 0 dB", To_Decibel (1.0), 0.0);
   Ada_Check.Equal ("0 dB is a factor of 1", To_Factor (0.0), 1.0);

   --  Below 1, the decibels go negative.
   Ada_Check.Equal ("halving is about -6 dB", To_Decibel (0.5), -6.0206, Tolerance => 0.005);
   Ada_Check.Equal ("-20 dB is a tenth", To_Factor (-20.0), 0.1, Tolerance => 0.0005);

   --  Each is the other's inverse, which catches a 10 written for a 20 in one of them.
   for I in 1 .. 8 loop
      declare
         F : constant Float := Float (I) * 1.5;
      begin
         Ada_Check.Equal ("round trip through decibels at" & Float'Image (F),
                          To_Factor (To_Decibel (F)), F, Tolerance => 0.001);
      end;
   end loop;

   for I in -4 .. 4 loop
      declare
         D : constant Float := Float (I) * 7.0;
      begin
         Ada_Check.Equal ("round trip through factors at" & Float'Image (D),
                          To_Decibel (To_Factor (D)), D, Tolerance => 0.001);
      end;
   end loop;

   --  Doubling the factor adds the same amount every time -- the property the scale exists for.
   Ada_Check.Equal ("doubling always adds the same",
                    To_Decibel (8.0) - To_Decibel (4.0),
                    To_Decibel (4.0) - To_Decibel (2.0),
                    Tolerance => 0.001);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Decibel_Factor;
