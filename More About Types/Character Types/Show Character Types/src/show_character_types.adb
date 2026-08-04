with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Character_Types is
   --  A character literal is an enumeration literal, so a character type is just an enumeration
   --  whose values happen to be written in quotes. Which means you can declare your own, with
   --  exactly the characters you want and no others.
   type My_Char is ('a', 'b', 'c');

   C : Character;   --  the built-in one, which is an enumeration too
   M : My_Char;
begin
   C := '?';
   M := 'a';

   Put_Line ("C is " & C);
   Put_Line ("M is " & My_Char'Image (M));

   --  Being an enumeration, Character has 'Val and 'Pos like any other.
   C := Character'Val (65);
   Put_Line ("Character'Val (65) is " & C);
   Put_Line ("and 'A' sits at position" & Integer'Image (Character'Pos ('A')));

   --  My_Char has three values and that is all it has. 'd' is not one of them, and neither is
   --  any Character -- see the task description for what the compiler says to each.
   for Ch in My_Char loop
      Put (My_Char'Image (Ch) & " ");
   end loop;
   New_Line;

   Put_Line ("My_Char has" & Integer'Image (My_Char'Pos (My_Char'Last) + 1) & " values;"
             & " Character has" & Integer'Image (Character'Pos (Character'Last) + 1));
end Show_Character_Types;
