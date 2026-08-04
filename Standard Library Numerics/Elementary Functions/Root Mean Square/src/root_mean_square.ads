--  The root-mean-square of a sequence: square everything, take the mean, take the square root.
--  It is the standard way to put a single number on the size of a signal.
package Root_Mean_Square is

   subtype Sig_Value is Float;

   type Signal is array (Natural range <>) of Sig_Value;

   function Rms (S : Signal) return Sig_Value;

end Root_Mean_Square;
