with Ada.Command_Line;
with Ada_Check;
with Imp_Loops_Numbers;

procedure Test_Imp_Loops_Numbers is

   --  Integer'Image puts a space where the minus sign would go, so " 1" rather than "1". Spelling
   --  the expected values out with that space visible is deliberate: it is the first thing this
   --  exercise surprises people with, and a test that hid it would be teaching the wrong lesson.
   LF : constant String := (1 => ASCII.LF);

begin
   Ada_Check.Suite ("Numbers");

   Ada_Check.Equal
     (Name     => "counts up from 1 to 5",
      Actual   => Ada_Check.Output_Of (Imp_Loops_Numbers'Access, 1, 5),
      Expected => " 1" & LF & " 2" & LF & " 3" & LF & " 4" & LF & " 5");

   --  Given backwards, it must still count upwards -- this is the half of the exercise that is
   --  easy to miss, because the obvious `for I in A .. B` loop simply prints nothing.
   Ada_Check.Equal
     (Name     => "counts up even when given 5 and 1",
      Actual   => Ada_Check.Output_Of (Imp_Loops_Numbers'Access, 5, 1),
      Expected => " 1" & LF & " 2" & LF & " 3" & LF & " 4" & LF & " 5");

   Ada_Check.Equal
     (Name     => "a range of one number",
      Actual   => Ada_Check.Output_Of (Imp_Loops_Numbers'Access, 3, 3),
      Expected => " 3");

   Ada_Check.Equal
     (Name     => "a range crossing zero",
      Actual   => Ada_Check.Output_Of (Imp_Loops_Numbers'Access, -2, 1),
      Expected => "-2" & LF & "-1" & LF & " 0" & LF & " 1");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Imp_Loops_Numbers;
