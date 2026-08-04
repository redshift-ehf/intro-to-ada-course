with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Task_Types is

   --  `task type` declares a kind of task rather than one task. Nothing runs until an object
   --  of the type is declared.
   task type Worker (ID : Positive) is
      entry Report;
   end Worker;

   task body Worker is
   begin
      accept Report do
         Put_Line ("worker" & Positive'Image (ID) & " reporting");
      end Report;
   end Worker;

   --  A discriminant, exactly as on a record: each worker knows which one it is.
   W1 : Worker (1);
   W2 : Worker (2);
   W3 : Worker (3);
begin
   --  Written inside each rendezvous, so these three lines come out in this order however the
   --  three tasks happen to be scheduled.
   W1.Report;
   W2.Report;
   W3.Report;

   --  An array of tasks works too, which is how you get a pool:
   declare
      type Team is array (1 .. 3) of Worker (9);
      Crew : Team;
   begin
      for W of Crew loop
         W.Report;
      end loop;
   end;
end Show_Task_Types;
