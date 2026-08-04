with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Instantiation is

   generic
      type T is private;
      Slot : in out T;
   procedure Set (Value : T);

   procedure Set (Value : T) is
   begin
      Slot := Value;
   end Set;

   Main    : Integer := 0;
   Current : Integer;

   --  `is new` is the instantiation. It maps every formal to an actual -- the type T to
   --  Integer, the object Slot to Main -- and produces a real procedure with a real name.
   procedure Set_Main is new Set (T => Integer, Slot => Main);

   --  Named association is worth the keystrokes here. A list of bare actuals in declaration
   --  order says nothing about which formal each one is for.
begin
   Current := 10;
   Set_Main (Current);
   Put_Line ("Main is" & Integer'Image (Main));

   Current := 25;
   Set_Main (Current);
   Put_Line ("Main is now" & Integer'Image (Main));

   --  The same syntax instantiates functions and packages:
   --
   --     function Get_Main is new ...
   --     package Integer_Queue is new ...
end Show_Instantiation;
