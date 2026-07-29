--  Minimal test reporting for the Ada course.
--
--  Prints TeamCity service messages, which IntelliJ's SM test runner consumes directly, so an
--  ordinary Ada program populates the IDE's test tree with no test framework involved.
with GNAT.Source_Info;

package Ada_Check is

   --  Opens the suite. Prints `enteredTheMatrix`, without which a clean exit is still reported
   --  as "Test framework quit unexpectedly".
   procedure Suite (Name : String);

   --  Closes the suite. The test main's exit status should be Failures.
   procedure Finish;

   procedure Check
     (Name      : String;
      Condition : Boolean;
      Detail    : String  := "";
      File      : String  := GNAT.Source_Info.File;
      Line      : Natural := GNAT.Source_Info.Line);

   procedure Equal
     (Name     : String;
      Actual   : String;
      Expected : String;
      File     : String  := GNAT.Source_Info.File;
      Line     : Natural := GNAT.Source_Info.Line);

   procedure Equal
     (Name     : String;
      Actual   : Integer;
      Expected : Integer;
      File     : String  := GNAT.Source_Info.File;
      Line     : Natural := GNAT.Source_Info.Line);

   function Failures return Natural;

   --  Runs a procedure and returns everything it wrote to standard output.
   --
   --  Nearly every exercise in this course is a procedure that *prints* — that is the shape the
   --  original labs use, and keeping it means a student's solution looks like the Ada they were
   --  just shown rather than like something bent to suit a test. So the test captures the output
   --  instead of asking the exercise to return it.
   --
   --  A parameterless library-level procedure is both a runnable main and an ordinary callable
   --  subprogram, which is what makes this work: the same file the student runs with the Run
   --  button is the one the test calls.
   --
   --  The parameter is an ANONYMOUS access-to-subprogram, not a named access type, and that is
   --  what lets an exercise take arguments. Most exercises after the first do: `Greet (Name :
   --  String)`, `Classify_Number (X : Integer)`. To call one of those, a test declares a nested
   --  procedure that supplies the arguments and passes that:
   --
   --     declare
   --        procedure Call is begin Greet ("John"); end Call;
   --     begin
   --        Ada_Check.Equal ("greets John", Output_Of (Call'Access), "Hello John!");
   --     end;
   --
   --  A named library-level access type cannot accept that -- `Call` is declared deeper than the
   --  type, and GNAT rejects it with "subprogram must not be deeper than access type". An
   --  anonymous access parameter takes its accessibility from the call instead, so the nested
   --  procedure is legal. Both forms were compiled to confirm it before this was written.
   function Output_Of (Run : access procedure) return String;

   --  Argument-supplying forms of the above, for the shapes this course actually uses. They exist
   --  because the nested-procedure dance is three lines of noise per assertion and these read as
   --  one, not because the general form cannot express them -- it can, and remains the way to
   --  reach any shape not listed here.
   function Output_Of
     (Run : access procedure (Item : String); Arg : String) return String;
   function Output_Of
     (Run : access procedure (Item : Integer); Arg : Integer) return String;
   function Output_Of
     (Run : access procedure (First, Second : Integer); A, B : Integer) return String;

end Ada_Check;
