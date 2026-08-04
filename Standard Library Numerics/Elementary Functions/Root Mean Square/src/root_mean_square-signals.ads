--  Three signals to measure. Written for you: the exercise is Rms, not signal generation.
package Root_Mean_Square.Signals is

   Sample_Rate : constant Float := 8000.0;

   function Generate_Sine (N : Positive; Freq : Float) return Signal;

   function Generate_Square (N : Positive) return Signal;

   function Generate_Triangular (N : Positive) return Signal;

end Root_Mean_Square.Signals;
