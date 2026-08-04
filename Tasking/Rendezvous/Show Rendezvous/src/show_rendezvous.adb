with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Rendezvous is

   task T is
      --  An entry is a synchronisation point another task can call.
      entry Start;
      entry Add (Value : Integer);
   end T;

   task body T is
      Total : Integer := 0;
   begin
      --  T stops here until somebody calls T.Start. That meeting is the rendezvous.
      accept Start;
      Put_Line ("T has started");

      --  `accept ... do ... end` runs statements *while both tasks are held together*. The
      --  caller does not continue until the end of the block, so this is how you hand data
      --  across and know it arrived.
      accept Add (Value : Integer) do
         Total := Total + Value;
      end Add;

      accept Add (Value : Integer) do
         Total := Total + Value;
      end Add;

      Put_Line ("T totalled" & Integer'Image (Total));
   end T;

begin
   Put_Line ("main is about to start T");

   T.Start;
   T.Add (10);
   T.Add (32);

   --  Each call above blocked until T accepted it, so all four lines are in a fixed order --
   --  unlike the first lesson, where nothing was.
end Show_Rendezvous;
