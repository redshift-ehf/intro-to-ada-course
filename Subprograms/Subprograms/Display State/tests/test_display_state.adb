with Ada.Command_Line;
with Ada_Check;
with Display_State;

procedure Test_Display_State is
begin
   Ada_Check.Suite ("Display State");

   Ada_Check.Equal ("state 0", Ada_Check.Output_Of (Display_State'Access, 0), "Off");
   Ada_Check.Equal ("state 1", Ada_Check.Output_Of (Display_State'Access, 1),
                    "On: Simple Processing");
   Ada_Check.Equal ("state 2", Ada_Check.Output_Of (Display_State'Access, 2),
                    "On: Advanced Processing");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Display_State;
