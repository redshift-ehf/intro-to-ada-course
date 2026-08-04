with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Dynamic_Records is
   --  Stands in for something a real program would work out at startup -- a configuration file,
   --  an environment variable, the size of a device. The point is that it is not a literal.
   function Compute_Max_Len return Natural is
   begin
      return 16;
   end Compute_Max_Len;

   Max_Len : constant Natural := Compute_Max_Len;

   type Items_Array is array (Positive range <>) of Integer;

   --  Items is as long as Max_Len, which nobody knew when this was compiled. The record type is
   --  still perfectly ordinary: its size is settled once, when the declaration is elaborated,
   --  and every object of it is that size for the rest of the run.
   type Growable_Stack is record
      Items : Items_Array (1 .. Max_Len);
      Len   : Natural := 0;
   end record;

   G : Growable_Stack;
   H : Growable_Stack;
begin
   Put_Line ("Max_Len was decided at run time:" & Natural'Image (Max_Len));
   Put_Line ("so a Growable_Stack holds" & Integer'Image (G.Items'Length) & " items");
   Put_Line ("and so does every other one:" & Integer'Image (H.Items'Length));

   G.Items (1) := 42;
   G.Len := 1;
   Put_Line ("first item" & Integer'Image (G.Items (1))
             & ", length" & Natural'Image (G.Len));
end Show_Dynamic_Records;
