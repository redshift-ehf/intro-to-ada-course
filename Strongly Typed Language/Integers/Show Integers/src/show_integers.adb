with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Integers is
   --  The bounds are the declaration. You say what the values are, not how many bits to use --
   --  picking a width is the compiler's job.
   type My_Int is range -1 .. 20;

   A : constant My_Int := 12;
   B : constant My_Int := 15;

   --  A + B is 27, which is outside My_Int. This is still legal, and does not raise: only the
   --  result has to fit the type, and 13 does. Intermediate values are computed with enough
   --  range to hold them.
   Mean : constant My_Int := (A + B) / 2;
begin
   for I in My_Int range 0 .. 4 loop
      Put (My_Int'Image (I));
   end loop;
   New_Line;

   Put_Line ("mean of" & My_Int'Image (A) & " and" & My_Int'Image (B)
             & " is" & My_Int'Image (Mean));
end Show_Integers;
