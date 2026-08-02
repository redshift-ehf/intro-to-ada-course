with Ada.Command_Line;
with Ada_Check;
with Say_Hello;

procedure Test_Say_Hello is
begin
   Ada_Check.Suite ("Hello World");

   --  The exercise prints rather than returns, which is the shape the original lab uses, so the
   --  harness captures standard output while calling it. `Say_Hello` is a parameterless
   --  library-level procedure, so it is both the program you can Run and an ordinary subprogram
   --  this test can call.
   Ada_Check.Equal
     (Name     => "the application displays Hello World!",
      Actual   => Ada_Check.Output_Of (Say_Hello'Access),
      Expected => "Hello World!");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Say_Hello;
