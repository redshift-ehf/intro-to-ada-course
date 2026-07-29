with Ada.Command_Line;
with Ada_Check;
with Imp_Hello_Greetings;

procedure Test_Imp_Hello_Greetings is
begin
   Ada_Check.Suite ("Greetings");

   --  Three names rather than one. The original lab reads a single name from the command line, so
   --  it can only ever exercise one; a procedure that takes its argument can be called as often as
   --  the test likes, and a solution that ignores Name and prints "Hello John!" outright fails on
   --  the second case instead of passing.
   Ada_Check.Equal
     (Name     => "greets John",
      Actual   => Ada_Check.Output_Of (Imp_Hello_Greetings'Access, "John"),
      Expected => "Hello John!");

   Ada_Check.Equal
     (Name     => "greets Ada",
      Actual   => Ada_Check.Output_Of (Imp_Hello_Greetings'Access, "Ada"),
      Expected => "Hello Ada!");

   --  A name with a space in it, which catches a solution that tries to be clever about words.
   Ada_Check.Equal
     (Name     => "greets a full name",
      Actual   => Ada_Check.Output_Of (Imp_Hello_Greetings'Access, "Ada Lovelace"),
      Expected => "Hello Ada Lovelace!");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Imp_Hello_Greetings;
