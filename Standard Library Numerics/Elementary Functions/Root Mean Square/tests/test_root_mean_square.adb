with Ada.Command_Line;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada_Check;
with Root_Mean_Square.Signals;

use Root_Mean_Square;
use Root_Mean_Square.Signals;

procedure Test_Root_Mean_Square is
   N : constant Positive := 1024;
begin
   Ada_Check.Suite ("Root-mean-square");

   --  The lab's own three cases, to the two decimal places it prints.
   Ada_Check.Equal ("a sine wave", Rms (Generate_Sine (N, 440.0)), 0.71, Tolerance => 0.005);
   Ada_Check.Equal ("a square wave", Rms (Generate_Square (N)), 1.00, Tolerance => 0.005);
   Ada_Check.Equal ("a triangle wave", Rms (Generate_Triangular (N + 1)), 0.58,
                    Tolerance => 0.005);

   --  A sine's RMS is its amplitude over root two, exactly. The 0.71 above is that, rounded.
   Ada_Check.Equal ("and the sine matches 1/sqrt(2)",
                    Rms (Generate_Sine (N, 440.0)), 1.0 / Sqrt (2.0), Tolerance => 0.005);

   --  Constants: the RMS of a constant signal is that constant, whatever its sign.
   Ada_Check.Equal ("all threes", Rms ((0 .. 9 => 3.0)), 3.0);
   Ada_Check.Equal ("all minus threes", Rms ((0 .. 9 => -3.0)), 3.0);

   --  Which is the difference from a mean: this one is zero on average and 1.0 RMS.
   Ada_Check.Equal ("alternating plus and minus one",
                    Rms ((1.0, -1.0, 1.0, -1.0)), 1.0);

   --  A worked case: sqrt ((9 + 16) / 2) = sqrt (12.5).
   Ada_Check.Equal ("three and four", Rms ((3.0, 4.0)), Sqrt (12.5), Tolerance => 0.0001);

   --  One element is its own RMS, and zero elements must not divide by zero.
   Ada_Check.Equal ("a single value", Rms ((0 => 2.5)), 2.5);

   declare
      Nothing : constant Signal (0 .. -1) := (0 .. -1 => 0.0);
   begin
      Ada_Check.Equal ("no values at all", Rms (Nothing), 0.0);
   end;

   --  Scaling the signal scales the RMS by the same amount.
   declare
      Base   : constant Signal := (1.0, 2.0, 3.0, 4.0);
      Scaled : constant Signal := (2.0, 4.0, 6.0, 8.0);
   begin
      Ada_Check.Equal ("doubling the signal doubles the RMS",
                       Rms (Scaled), 2.0 * Rms (Base), Tolerance => 0.0001);
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Root_Mean_Square;
