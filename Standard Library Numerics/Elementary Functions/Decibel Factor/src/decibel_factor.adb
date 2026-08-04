with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body Decibel_Factor is

   function To_Decibel (F : Factor) return Decibel is
   begin
      --  Log with a second argument is the logarithm to that base.
      return 20.0 * Log (F, 10.0);
   end To_Decibel;

   function To_Factor (D : Decibel) return Factor is
   begin
      return 10.0 ** (D / 20.0);
   end To_Factor;

end Decibel_Factor;
