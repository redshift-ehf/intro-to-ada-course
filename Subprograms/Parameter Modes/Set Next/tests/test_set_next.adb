with Ada.Command_Line;
with Ada_Check;
with Set_Next;

procedure Test_Set_Next is
   State : Integer;
begin
   Ada_Check.Suite ("Set Next");

   State := 0;
   Set_Next (State);
   Ada_Check.Equal ("0 becomes 1", State, 1);

   State := 1;
   Set_Next (State);
   Ada_Check.Equal ("1 becomes 2", State, 2);

   --  The wrap. A solution that only increments passes the first two and fails here.
   State := 2;
   Set_Next (State);
   Ada_Check.Equal ("2 wraps to 0", State, 0);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Set_Next;
