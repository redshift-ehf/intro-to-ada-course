with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body Root_Mean_Square is

   function Rms (S : Signal) return Sig_Value is
      Total : Sig_Value := 0.0;
   begin
      if S'Length = 0 then
         return 0.0;
      end if;

      --  Squaring and summing in one pass, rather than building the squared sequence first.
      for V of S loop
         Total := Total + V * V;
      end loop;

      return Sqrt (Total / Sig_Value (S'Length));
   end Rms;

end Root_Mean_Square;
