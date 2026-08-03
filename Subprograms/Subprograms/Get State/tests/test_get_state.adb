with Ada.Command_Line;
with Ada_Check;
with Get_State;

procedure Test_Get_State is
begin
   Ada_Check.Suite ("Get State");

   Ada_Check.Equal ("state 0", Get_State (0), "Off");
   Ada_Check.Equal ("state 1", Get_State (1), "On: Simple Processing");
   Ada_Check.Equal ("state 2", Get_State (2), "On: Advanced Processing");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Get_State;
