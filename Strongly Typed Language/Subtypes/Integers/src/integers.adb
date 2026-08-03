package body Integers is

   --  The three conversions are given. Each one crosses between distinct types and so has to be
   --  written out, even where the values are identical.

   function To_I_100 (V : U_100) return I_100 is
   begin
      return I_100 (V);
   end To_I_100;

   function To_U_100 (V : I_100) return U_100 is
   begin
      return U_100 (V);
   end To_U_100;

   function To_I_100 (V : D_50) return I_100 is
   begin
      return I_100 (V);
   end To_I_100;

   function To_D_50 (V : I_100) return D_50 is
   begin
      if V < 10 then
         return D_50'First;
      elsif V > 50 then
         return D_50'Last;
      else
         return D_50 (V);
      end if;
   end To_D_50;

   function To_S_50 (V : I_100) return S_50 is
   begin
      if V < 10 then
         return S_50'First;
      elsif V > 50 then
         return S_50'Last;
      else
         --  No conversion here, and none allowed to be needed: S_50 IS I_100.
         return V;
      end if;
   end To_S_50;

end Integers;
