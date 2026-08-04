with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Discriminants is
   type Items_Array is array (Positive range <>) of Integer;

   --  Max_Len is a discriminant: part of the type, chosen per object, and fixed from then on.
   --  So two Growable_Stacks can be different sizes, which the last lesson could not manage.
   type Growable_Stack (Max_Len : Natural) is record
      Items : Items_Array (1 .. Max_Len);
      Len   : Natural := 0;
   end record;

   --  With no default, the type is indefinite -- exactly as `range <>` makes an array type --
   --  so every object has to say which one it is.
   Small : Growable_Stack (4);
   Large : Growable_Stack (128) := (Max_Len => 128,
                                    Items   => (1, 2, 3, 4, others => 0),
                                    Len     => 4);

   --  With a default, the type is definite again and an object may say nothing.
   type Point (X, Y : Natural := 0) is record
      null;
   end record;

   P1 : Point;             --  takes the defaults
   P2 : Point (1, 2);      --  constrained where it is declared
   P3 : Point := (1, 2);   --  constrained by its value

   procedure Print_Stack (G : Growable_Stack) is
   begin
      Put ("<Stack, items: [");
      for I in G.Items'Range loop
         exit when I > G.Len;
         Put (" " & Integer'Image (G.Items (I)));
      end loop;
      Put_Line ("]>");
   end Print_Stack;
begin
   Small.Items (1) := 7;
   Small.Len := 1;

   --  One procedure takes both, because both are the same type. Only the constraint differs.
   Print_Stack (Small);
   Print_Stack (Large);

   --  A discriminant is readable like any component. It is only writing it that is refused.
   Put_Line ("Small holds up to" & Natural'Image (Small.Max_Len)
             & ", Large up to" & Natural'Image (Large.Max_Len));

   Put_Line ("P1 =" & Natural'Image (P1.X) & Natural'Image (P1.Y)
             & ", P2 =" & Natural'Image (P2.X) & Natural'Image (P2.Y)
             & ", P3 =" & Natural'Image (P3.X) & Natural'Image (P3.Y));
end Show_Discriminants;
