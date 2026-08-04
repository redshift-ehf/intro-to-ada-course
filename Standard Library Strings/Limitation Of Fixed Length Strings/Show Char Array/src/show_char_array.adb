with Ada.Text_IO; use Ada.Text_IO;

--  A String is an array of Character, and that is the whole limitation. Assigning to one means
--  assigning an array of exactly the right length.
procedure Show_Char_Array is
   S : String (1 .. 15);
begin
   --  `S := "Hello";` does not compile: the lengths differ. So the padding is written by hand.
   S := "Hello          ";

   --  Or, equivalently:
   --
   --    S (1 .. 5)      := "Hello";
   --    S (6 .. S'Last) := (others => ' ');
   --
   --    S := ('H', 'e', 'l', 'l', 'o', others => ' ');

   Put_Line ("String: '" & S & "'");
   Put_Line ("String Length: " & Integer'Image (S'Length));

   --  Both of those alternatives, so they can be seen working.
   S (1 .. 5)      := "World";
   S (6 .. S'Last) := (others => ' ');
   Put_Line ("String: '" & S & "'");

   S := ('A', 'd', 'a', others => ' ');
   Put_Line ("String: '" & S & "'");

   --  This is fine when the value is known at the declaration -- the length comes from the value
   --  and nobody has to count.
   declare
      T : constant String := "No counting needed";
   begin
      Put_Line ("String: '" & T & "'");
      Put_Line ("String Length: " & Integer'Image (T'Length));
   end;

   --  What it cannot do is change. The next two lessons are the two ways round that.
end Show_Char_Array;
