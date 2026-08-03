with Ada.Command_Line;
with Ada_Check;
with Operations;
with Operations.Test;

procedure Test_Operations is
begin
   Ada_Check.Suite ("Operations");

   Ada_Check.Equal ("100 + 2", Operations.Add (100, 2),      102);
   Ada_Check.Equal ("100 - 2", Operations.Subtract (100, 2), 98);
   Ada_Check.Equal ("100 * 2", Operations.Multiply (100, 2), 200);
   Ada_Check.Equal ("100 / 2", Operations.Divide (100, 2),   50);

   --  Integer division truncates, which is worth asserting rather than assuming.
   Ada_Check.Equal ("1 / 2 truncates", Operations.Divide (1, 2), 0);

   declare
      Printed : constant String :=
        Ada_Check.Output_Of (Operations.Test.Display'Access, 10, 5);
   begin
      Ada_Check.Equal
        (Name     => "the child package displays all four",
         Actual   => Printed,
         Expected =>
           "Operations:" & ASCII.LF
           & " 10 +  5 =  15," & ASCII.LF
           & " 10 -  5 =  5," & ASCII.LF
           & " 10 *  5 =  50," & ASCII.LF
           & " 10 /  5 =  2,");
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Operations;
