with Ada.Command_Line;
with Ada_Check;
with Display_On_Off;

procedure Test_Display_On_Off is
begin
   Ada_Check.Suite ("Display On Off");

   Ada_Check.Equal ("state 0 is off", Ada_Check.Output_Of (Display_On_Off'Access, 0), "Off");
   Ada_Check.Equal ("state 1 is on",  Ada_Check.Output_Of (Display_On_Off'Access, 1), "On");
   --  Two counts as on. A solution testing `State = 1` passes the first two and fails here.
   Ada_Check.Equal ("state 2 is on",  Ada_Check.Output_Of (Display_On_Off'Access, 2), "On");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Display_On_Off;
