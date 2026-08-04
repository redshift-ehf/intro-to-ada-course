with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Formal_Objects is

   --  A formal *object*, not a type. It looks like a parameter and behaves like one, except
   --  that it is fixed at instantiation rather than passed at each call.
   generic
      Label : String;
      type T is private;
      Slot : in out T;
   procedure Store (Value : T);

   procedure Store (Value : T) is
   begin
      Slot := Value;
      Put_Line (Label & ": stored");
   end Store;

   Main    : Integer := 0;
   Backup  : Integer := 0;

   --  Two instances of one generic, each wired to a different variable. Neither takes the
   --  destination as an argument -- it is part of what the instance *is*.
   procedure Store_Main   is new Store (Label => "main",   T => Integer, Slot => Main);
   procedure Store_Backup is new Store (Label => "backup", T => Integer, Slot => Backup);
begin
   Store_Main (10);
   Store_Backup (20);

   Put_Line ("Main is" & Integer'Image (Main)
             & ", Backup is" & Integer'Image (Backup));

   Store_Main (30);
   Put_Line ("after storing again, Main is" & Integer'Image (Main)
             & " and Backup is still" & Integer'Image (Backup));

   --  `Label : String` is mode `in`, the default: a constant for the life of the instance.
   --  `Slot : in out T` is a variable the instance writes through.
end Show_Formal_Objects;
