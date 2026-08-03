--  Four ways to say "a whole number in a range", and what separates them.
package Integers is

   type I_100 is range 0 .. 100;

   --  A modular type with 101 values, so 0 .. 100 -- the same values as I_100, and still a
   --  different type.
   type U_100 is mod 101;

   --  A derived type: a new type with I_100's structure and operations, narrowed.
   type D_50 is new I_100 range 10 .. 50;

   --  A subtype: not a new type at all, just I_100 with a constraint on it.
   subtype S_50 is I_100 range 10 .. 50;

   function To_I_100 (V : U_100) return I_100;

   function To_U_100 (V : I_100) return U_100;

   --  These two saturate rather than raise: anything below 10 comes back as 10, anything above
   --  50 comes back as 50.
   function To_D_50 (V : I_100) return D_50;

   function To_S_50 (V : I_100) return S_50;

   function To_I_100 (V : D_50) return I_100;

end Integers;
