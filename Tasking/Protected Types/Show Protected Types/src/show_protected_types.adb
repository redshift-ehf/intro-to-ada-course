with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Protected_Types is

   --  `protected type` is to a protected object what `task type` is to a task: a template, and
   --  nothing exists until an object of it is declared.
   protected type Counter is
      procedure Bump;
      function Value return Natural;
      procedure Reset;
   private
      Count : Natural := 0;
   end Counter;

   protected body Counter is
      procedure Bump is
      begin
         Count := Count + 1;
      end Bump;

      function Value return Natural is
      begin
         return Count;
      end Value;

      procedure Reset is
      begin
         Count := 0;
      end Reset;
   end Counter;

   --  Two counters, each with its own Count, each independently safe against concurrent use.
   Hits   : Counter;
   Misses : Counter;

   task type Hitter;
   task body Hitter is
   begin
      for I in 1 .. 500 loop
         Hits.Bump;
      end loop;
   end Hitter;

begin
   Misses.Bump;
   Misses.Bump;

   declare
      A, B : Hitter;
   begin
      null;
   end;

   Put_Line ("hits:  " & Natural'Image (Hits.Value));
   Put_Line ("misses:" & Natural'Image (Misses.Value));

   Hits.Reset;
   Put_Line ("after reset, hits:" & Natural'Image (Hits.Value)
             & " and misses are untouched at" & Natural'Image (Misses.Value));
end Show_Protected_Types;
