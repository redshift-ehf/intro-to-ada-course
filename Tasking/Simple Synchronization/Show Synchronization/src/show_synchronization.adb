with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Synchronization is
   task T;

   task body T is
   begin
      for I in 1 .. 5 loop
         Put_Line ("hello from T," & Integer'Image (I));
      end loop;
      Put_Line ("T has finished");
   end T;
begin
   Put_Line ("main has nothing to do");

   --  And yet the program does not end here. A master waits for every subtask declared in it
   --  before it may finish, so this procedure cannot return until T has run to completion.
   --
   --  That waiting is the first and simplest synchronisation Ada gives you, and it is free: no
   --  join, no handle, nothing to remember to call.
end Show_Synchronization;
