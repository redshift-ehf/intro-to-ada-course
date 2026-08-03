--  Temperatures in Celsius and Kelvin, as distinct floating-point types with real bounds.
package Temperatures is

   --  From absolute zero to the surface of the Sun. The two scales stop at the same two physical
   --  points, which is why the numbers look arbitrary: 5504.85 C is 5778 K.
   type Celsius is digits 6 range -273.15 .. 5504.85;

   type Int_Celsius is range -273 .. 5505;

   type Kelvin is digits 6 range 0.0 .. 5778.0;

   function To_Celsius (T : Int_Celsius) return Celsius;

   function To_Int_Celsius (T : Celsius) return Int_Celsius;

   function To_Celsius (K : Kelvin) return Celsius;

   function To_Kelvin (C : Celsius) return Kelvin;

end Temperatures;
