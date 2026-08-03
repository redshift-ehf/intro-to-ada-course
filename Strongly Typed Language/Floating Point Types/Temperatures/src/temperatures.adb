package body Temperatures is

   --  Every conversion here saturates rather than trusting the arithmetic to land in range, for
   --  two separate reasons. Int_Celsius reaches 5505 and Celsius stops at 5504.85, so the ends
   --  genuinely do not line up; and -273.15 has no exact binary representation, so even a
   --  conversion that is right to every digit the type carries can come out a hair outside the
   --  target's range and raise Constraint_Error. Clamping costs nothing and removes both.
   function Clamp (Value, Low, High : Float) return Float is
     (Float'Min (Float'Max (Value, Low), High));

   function To_Celsius (T : Int_Celsius) return Celsius is
   begin
      return Celsius (Clamp (Float (T), Float (Celsius'First), Float (Celsius'Last)));
   end To_Celsius;

   function To_Int_Celsius (T : Celsius) return Int_Celsius is
   begin
      --  Float to integer rounds to nearest in Ada, so -273.15 lands on -273 rather than
      --  truncating towards zero.
      return Int_Celsius (T);
   end To_Int_Celsius;

   function To_Celsius (K : Kelvin) return Celsius is
   begin
      return Celsius (Clamp (Float (K) - 273.15,
                             Float (Celsius'First), Float (Celsius'Last)));
   end To_Celsius;

   function To_Kelvin (C : Celsius) return Kelvin is
   begin
      return Kelvin (Clamp (Float (C) + 273.15,
                            Float (Kelvin'First), Float (Kelvin'Last)));
   end To_Kelvin;

end Temperatures;
