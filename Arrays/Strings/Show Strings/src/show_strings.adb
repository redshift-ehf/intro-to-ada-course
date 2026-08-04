with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Strings is
   --  String is not a special case built into the language. Standard declares it as
   --
   --     type String is array (Positive range <>) of Character;
   --
   --  and everything in this chapter applies to it unchanged.
   Message : constant String := "dlroW olleH";

   --  A string literal is an aggregate, so these two are the same value written two ways.
   A : constant String (1 .. 5) := "Hello";
   B : constant String (1 .. 5) := ('H', 'e', 'l', 'l', 'o');
begin
   for I in reverse Message'Range loop
      Put (Message (I));
   end loop;
   New_Line;

   Put_Line ("A = " & A & ", B = " & B & ", equal: " & Boolean'Image (A = B));

   --  Message was declared with no bounds at all: they came from the initial value.
   Put_Line ("Message is" & Integer'Image (Message'Length) & " characters, indexed"
             & Integer'Image (Message'First) & " .." & Integer'Image (Message'Last));
end Show_Strings;
