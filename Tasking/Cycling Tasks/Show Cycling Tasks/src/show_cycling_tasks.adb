with Ada.Text_IO;   use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

procedure Show_Cycling_Tasks is

   Start_Time : constant Time := Clock;

   procedure Show_Elapsed (Label : String) is
   begin
      Put_Line (Label & Duration'Image (To_Duration (Clock - Start_Time)) & " s");
   end Show_Elapsed;

   --  Stands in for real work. Whatever this costs is what makes the difference below.
   procedure Busy is
   begin
      delay 0.05;
   end Busy;

   Cycle : constant Time_Span := Milliseconds (100);

   task Cycler;

   task body Cycler is
      Next : Time;
   begin
      --  `delay` waits that long *starting now*, so the work is added to the wait every time
      --  round and the loop falls further behind with each cycle.
      Put_Line ("drifting -- delay 0.1 each time round:");
      for I in 1 .. 3 loop
         delay 0.1;
         Busy;
         Show_Elapsed ("  cycle" & Integer'Image (I) & " at");
      end loop;

      --  `delay until` names the moment to wake up, so the work happens *inside* the interval
      --  instead of being added to it. The cycles stay a tenth of a second apart.
      Put_Line ("steady -- delay until a fixed schedule:");
      Next := Clock + Cycle;
      for I in 1 .. 3 loop
         delay until Next;
         Busy;
         Next := Next + Cycle;
         Show_Elapsed ("  cycle" & Integer'Image (I) & " at");
      end loop;
   end Cycler;

begin
   null;
end Show_Cycling_Tasks;
