with Ada.Command_Line;
with Ada.Real_Time; use Ada.Real_Time;
with Ada_Check;
with Event_Manager;

procedure Test_Event_Manager is
   use Event_Manager;

   --  Five events, set up in the order 1..5 and due in a quite different order. What comes out
   --  is decided by the times, not by the order the entries were called -- which is the whole
   --  claim this exercise makes.
   --
   --  A tenth of a second apart. AdaCore's version uses whole seconds; this one is scaled down
   --  so the exercise costs half a second rather than five, and 100 ms is still far more
   --  separation than any scheduling jitter on a machine that can run a compiler.
   function Announced return String is
      procedure Call is
         Now : constant Time := Clock;
         E1, E2, E3, E4, E5 : Manager;
      begin
         E1.Start (1);
         E2.Start (2);
         E3.Start (3);
         E4.Start (4);
         E5.Start (5);

         E1.Event (Now + Milliseconds (500));
         E2.Event (Now + Milliseconds (200));
         E3.Event (Now + Milliseconds (400));
         E4.Event (Now + Milliseconds (100));
         E5.Event (Now + Milliseconds (300));
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Announced;
begin
   Ada_Check.Suite ("Event Manager");

   --  Due at 100, 200, 300, 400, 500 ms: events 4, 2, 5, 3, 1.
   Ada_Check.Equal
     (Name     => "events announce in time order, not call order",
      Actual   => Announced,
      Expected =>
        "Event # 4" & ASCII.LF
        & "Event # 2" & ASCII.LF
        & "Event # 5" & ASCII.LF
        & "Event # 3" & ASCII.LF
        & "Event # 1");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Event_Manager;
