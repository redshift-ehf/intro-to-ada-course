--  Decibels express the ratio of two values on a logarithmic scale. An increase of 6 dB is
--  roughly a doubling.
package Decibel_Factor is

   subtype Decibel is Float;
   subtype Factor  is Float;

   --  20 * log10 (F)
   function To_Decibel (F : Factor) return Decibel;

   --  10 ** (D / 20)
   function To_Factor (D : Decibel) return Factor;

end Decibel_Factor;
