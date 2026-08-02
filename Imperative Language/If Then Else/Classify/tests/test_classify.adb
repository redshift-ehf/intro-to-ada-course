with Ada.Command_Line;
with Ada_Check;
with Classify;

procedure Test_Classify is
begin
   Ada_Check.Suite ("Classify");

   Ada_Check.Equal
     (Name     => "a positive number",
      Actual   => Ada_Check.Output_Of (Classify'Access, 42),
      Expected => "Positive");

   Ada_Check.Equal
     (Name     => "a negative number",
      Actual   => Ada_Check.Output_Of (Classify'Access, -42),
      Expected => "Negative");

   --  Zero is the case an if/else with no elsif quietly gets wrong, so it is asked for twice:
   --  once as itself, and once at each edge of it.
   Ada_Check.Equal
     (Name     => "zero",
      Actual   => Ada_Check.Output_Of (Classify'Access, 0),
      Expected => "Zero");

   Ada_Check.Equal
     (Name     => "one, just above zero",
      Actual   => Ada_Check.Output_Of (Classify'Access, 1),
      Expected => "Positive");

   Ada_Check.Equal
     (Name     => "minus one, just below zero",
      Actual   => Ada_Check.Output_Of (Classify'Access, -1),
      Expected => "Negative");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Classify;
