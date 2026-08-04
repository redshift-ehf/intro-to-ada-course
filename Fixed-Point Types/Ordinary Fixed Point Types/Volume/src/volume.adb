package body Volume is

   function Scale (A, B : Gain) return Gain is
   begin
      --  Fixed times fixed is universal_fixed in Ada -- a type with no operations of its own --
      --  so the result has to be converted back before it can be returned. This conversion is
      --  not optional and not decoration; without it the code does not compile.
      return Gain (A * B);
   end Scale;

   function Mix (A, B : Gain) return Gain is
   begin
      --  Halved first, then added. Adding first could exceed Gain'Last and raise before the
      --  division ever ran.
      return A / 2 + B / 2;
   end Mix;

   function Fade (G : Gain; Steps : Natural) return Gain is
      Result : Gain := G;
   begin
      for Step in 1 .. Steps loop
         Result := Result / 2;
      end loop;
      return Result;
   end Fade;

   function Is_Silent (G : Gain) return Boolean is
   begin
      return G = 0.0;
   end Is_Silent;

end Volume;
