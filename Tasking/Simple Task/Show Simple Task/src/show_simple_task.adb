with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Simple_Task is
   --  `task` declares one. Its body says what it does, and it starts on its own.
   task T;

   task body T is
   begin
      Put_Line ("In task T");
   end T;

   task T2;

   task body T2 is
   begin
      Put_Line ("In task T2");
   end T2;
begin
   --  Three tasks are now running: T, T2, and this one. The main subprogram is itself a task --
   --  the environment task -- and T and T2 are its subtasks, because they are declared in it.
   Put_Line ("In main");

   --  Which of the three lines appears first is not decided here, and Run twice may not agree.
   --  Anything that needs an order has to say so; the rest of this chapter is how.
end Show_Simple_Task;
