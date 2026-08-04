with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Protected_Entries is

   protected Obj is
      procedure Set (V : Integer);
      --  An entry, not a procedure, because it can refuse to run yet.
      entry Get (V : out Integer);
   private
      Local  : Integer := 0;
      Is_Set : Boolean := False;
   end Obj;

   protected body Obj is
      procedure Set (V : Integer) is
      begin
         Local := V;
         Is_Set := True;
      end Set;

      --  The `when` is a barrier. A task calling Get while Is_Set is False does not fail and
      --  does not spin -- it sleeps, and is woken when the barrier becomes true. Barriers are
      --  re-evaluated whenever a procedure or entry of this object finishes.
      entry Get (V : out Integer) when Is_Set is
      begin
         V := Local;
         Is_Set := False;
      end Get;
   end Obj;

   N : Integer := 0;

   task T;

   task body T is
   begin
      Put_Line ("T will wait a moment before setting Obj");
      delay 0.2;
      Obj.Set (5);
      Put_Line ("T has set Obj");
   end T;

begin
   Put_Line ("main asks for Obj, before anyone has set it");

   --  This blocks until T calls Set. No polling, no sleeping-and-checking, and no chance of
   --  reading the value before it exists.
   Obj.Get (N);

   Put_Line ("main got it: " & Integer'Image (N));
end Show_Protected_Entries;
