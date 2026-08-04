with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Delay is

   task T;

   task body T is
   begin
      for I in 1 .. 5 loop
         Put_Line ("hello from task T");
         --  Seconds, as a fixed-point Duration. AdaCore's version waits a whole second here;
         --  this one waits a tenth, so the example finishes while you are still looking at it.
         delay 0.1;
      end loop;
   end T;
begin
   delay 0.15;
   Put_Line ("hello from main");

   --  `delay` puts *this* task to sleep and nobody else. T keeps going while main waits, which
   --  is the whole point -- and is why the two sets of lines interleave.
end Show_Delay;
