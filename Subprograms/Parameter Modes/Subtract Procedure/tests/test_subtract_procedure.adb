with Ada.Command_Line;
with Ada_Check;
with Subtract_Procedure;

procedure Test_Subtract_Procedure is
   Result : Integer;
begin
   Ada_Check.Suite ("Subtract Procedure");

   Subtract_Procedure (10, 1, Result);
   Ada_Check.Equal ("10 - 1", Result, 9);

   Subtract_Procedure (10, 100, Result);
   Ada_Check.Equal ("10 - 100", Result, -90);

   Subtract_Procedure (0, 5, Result);
   Ada_Check.Equal ("0 - 5", Result, -5);

   Subtract_Procedure (0, -5, Result);
   Ada_Check.Equal ("0 - (-5)", Result, 5);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Subtract_Procedure;
