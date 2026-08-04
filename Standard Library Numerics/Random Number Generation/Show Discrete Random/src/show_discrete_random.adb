with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

--  Random values of a discrete type. This one is generic, and the type parameter is where the
--  range comes from -- so the range is chosen by declaring a subtype, not by taking a remainder.
procedure Show_Discrete_Random is

   subtype Random_Range is Integer range 1 .. 10;

   package R is new Ada.Numerics.Discrete_Random (Random_Range);
   use R;

   G : Generator;
   X : Random_Range;
begin
   Reset (G);

   Put_Line ("Some random numbers between "
             & Integer'Image (Random_Range'First)
             & " and "
             & Integer'Image (Random_Range'Last) & ":");

   for I in 1 .. 10 loop
      X := Random (G);
      Put_Line (Integer'Image (X));
   end loop;

   --  Any discrete type, not just integers. An enumeration works the same way, and there is no
   --  conversion to get wrong.
   New_Line;
   declare
      type Suit is (Clubs, Diamonds, Hearts, Spades);

      package Suits is new Ada.Numerics.Discrete_Random (Suit);
      use Suits;

      SG : Suits.Generator;
   begin
      Reset (SG, 7);
      Put_Line ("Five cards, from seed 7:");
      for I in 1 .. 5 loop
         Put_Line (Suit'Image (Random (SG)));
      end loop;
   end;

   --  `Random (G) mod 6 + 1` is the version of this that everyone writes in other languages, and
   --  it is subtly biased whenever the range does not divide the generator's period. Declaring
   --  the subtype hands that problem to the implementation.
end Show_Discrete_Random;
