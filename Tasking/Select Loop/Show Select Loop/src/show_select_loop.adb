with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Select_Loop is

   task T is
      entry Reset;
      entry Increment;
   end T;

   task body T is
      Cnt : Integer := 0;
   begin
      loop
         --  `select` waits for whichever entry is called next, rather than fixing an order.
         select
            accept Reset do
               Cnt := 0;
            end Reset;
            Put_Line ("Reset");
         or
            accept Increment do
               Cnt := Cnt + 1;
            end Increment;
            Put_Line ("In T's loop (" & Integer'Image (Cnt) & ")");
         or
            --  Without this the loop never ends and the master can never finish. `terminate`
            --  says: if nobody can ever call again because the master is done, stop.
            terminate;
         end select;
      end loop;
   end T;

begin
   Put_Line ("In Main");

   for I in 1 .. 4 loop
      T.Increment;
   end loop;

   T.Reset;

   for I in 1 .. 4 loop
      T.Increment;
   end loop;

   --  Main falls off the end here. T is sitting in its select with nothing left that could call
   --  it, so the `terminate` alternative is taken and the program ends.
end Show_Select_Loop;
