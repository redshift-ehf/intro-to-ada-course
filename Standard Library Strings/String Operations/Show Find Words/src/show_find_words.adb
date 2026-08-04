with Ada.Strings;       use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Maps;  use Ada.Strings.Maps;
with Ada.Text_IO;       use Ada.Text_IO;

--  Splitting on separators, without a split function. Find_Token walks a string one token at a
--  time, and what counts as a separator is a set of characters you choose.
procedure Show_Find_Words is

   S : constant String := "Hello" & 3 * " World";
   F : Positive;
   L : Natural;
   I : Natural := 1;

   --  A Character_Set, from Ada.Strings.Maps. To_Set takes a character, a string of them, or a
   --  range.
   Whitespace : constant Character_Set := To_Set (' ');
begin
   Put_Line ("String: " & S);
   Put_Line ("String length: " & Integer'Image (S'Length));

   while I in S'Range loop
      --  Test => Outside means "find a run of characters NOT in the set" -- that is, a word.
      --  Inside would find the runs of whitespace instead.
      --
      --  First and Last come back as out parameters, and they are the range of the token.
      Find_Token (Source => S,
                  Set    => Whitespace,
                  From   => I,
                  Test   => Outside,
                  First  => F,
                  Last   => L);

      --  Last is 0 when there was nothing left to find.
      exit when L = 0;

      Put_Line ("Found word instance at position " & Natural'Image (F)
                & ": '" & S (F .. L) & "'");

      I := L + 1;
   end loop;

   --  The same walk with a bigger separator set. Nothing about Find_Token changes.
   declare
      Punctuation : constant Character_Set := To_Set (" ,.;");
      Text        : constant String := "one, two; three.";
      J           : Natural := 1;
   begin
      New_Line;
      Put_Line ("Splitting '" & Text & "' on spaces and punctuation:");
      while J in Text'Range loop
         Find_Token (Text, Punctuation, J, Outside, F, L);
         exit when L = 0;
         Put_Line ("- '" & Text (F .. L) & "'");
         J := L + 1;
      end loop;
   end;
end Show_Find_Words;
