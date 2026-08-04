with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO;       use Ada.Text_IO;

--  Operations on ordinary String live in Ada.Strings.Fixed -- "fixed" because a String is an
--  array of Character, and an array has the length it was declared with.
procedure Show_Find_Substring is

   --  "*" is from Ada.Strings.Fixed too: 3 * " World" is " World World World".
   S   : constant String := "Hello" & 3 * " World";
   P   : constant String := "World";
   Idx : Natural;
   Cnt : Natural;
begin
   --  Qualified because Ada.Strings.Fixed.Count and Ada.Containers' Count_Type are both about,
   --  and because Count is a common enough name to be worth being explicit about.
   Cnt := Ada.Strings.Fixed.Count (Source => S, Pattern => P);

   Put_Line ("String: " & S);
   Put_Line ("Count for '" & P & "': " & Natural'Image (Cnt));

   --  Index finds one occurrence. To find them all, start the next search past the last hit.
   Idx := 0;
   for I in 1 .. Cnt loop
      Idx := Index (Source => S, Pattern => P, From => Idx + 1);
      Put_Line ("Found instance of '" & P & "' at position: " & Natural'Image (Idx));
   end loop;

   --  Index returns 0 when there is nothing to find. Natural, not Positive, precisely so that
   --  it has a value meaning "no".
   Put_Line ("Looking for 'Goodbye': " & Natural'Image (Index (S, "Goodbye")));
end Show_Find_Substring;
