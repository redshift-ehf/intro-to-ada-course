with Ada.Numerics;                      use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body Root_Mean_Square.Signals is

   function Generate_Sine (N : Positive; Freq : Float) return Signal is
      S : Signal (0 .. N - 1);
   begin
      for I in S'Range loop
         S (I) := Sin (2.0 * Pi * (Freq * Float (I) / Sample_Rate));
      end loop;
      return S;
   end Generate_Sine;

   function Generate_Square (N : Positive) return Signal is
      S : constant Signal (0 .. N - 1) := (others => 1.0);
   begin
      return S;
   end Generate_Square;

   function Generate_Triangular (N : Positive) return Signal is
      S      : Signal (0 .. N - 1);
      S_Half : constant Natural := S'Last / 2;
   begin
      for I in S'First .. S_Half loop
         S (I) := Float (I) / Float (S_Half);
      end loop;
      for I in S_Half .. S'Last loop
         S (I) := 1.0 - (Float (I - S_Half) / Float (S_Half));
      end loop;
      return S;
   end Generate_Triangular;

end Root_Mean_Square.Signals;
