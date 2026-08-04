with Ada.Command_Line;
with Ada.Assertions;
with Ada_Check;
with Pythagoras_Postcondition;

procedure Test_Pythagoras_Postcondition is
   use Pythagoras_Postcondition;

   --  A contract that fails raises Assertion_Error. Reported as text so a test can assert on it
   --  either way round: that a legal triangle is built, and that an illegal one is refused.
   function Outcome (H, C1, C2 : Length) return String is
   begin
      declare
         T : constant Right_Triangle := Init (H, C1, C2);
      begin
         return "built" & Length'Image (T.H) & Length'Image (T.C1) & Length'Image (T.C2);
      end;
   exception
      when Ada.Assertions.Assertion_Error => return "refused";
   end Outcome;
begin
   Ada_Check.Suite ("Pythagorean Theorem: Postcondition");

   --  3-4-5 and its multiples are right triangles; the rest are not.
   Ada_Check.Equal ("10, 8, 6 is a right triangle",  Outcome (10, 8, 6),  "built 10 8 6");
   Ada_Check.Equal ("26, 10, 24 is one too",         Outcome (26, 10, 24), "built 26 10 24");
   Ada_Check.Equal ("30, 18, 24 is one too",         Outcome (30, 18, 24), "built 30 18 24");

   Ada_Check.Equal ("10, 8, 7 is not",   Outcome (10, 8, 7),   "refused");
   Ada_Check.Equal ("26, 10, 23 is not", Outcome (26, 10, 23), "refused");
   Ada_Check.Equal ("30, 18, 23 is not", Outcome (30, 18, 23), "refused");

   --  A degenerate all-zero triangle satisfies the theorem, which is why the default is legal.
   Ada_Check.Equal ("0, 0, 0 satisfies it", Outcome (0, 0, 0), "built 0 0 0");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Pythagoras_Postcondition;
