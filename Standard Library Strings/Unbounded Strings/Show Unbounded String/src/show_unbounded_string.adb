with Ada.Text_IO; use Ada.Text_IO;

with Ada.Strings.Unbounded;
use  Ada.Strings.Unbounded;

--  An unbounded string is a bounded one with the bound taken away. No maximum, so no
--  instantiation and no truncation mode anywhere.
procedure Show_Unbounded_String is
   S1, S2 : Unbounded_String;

   procedure Display_String_Info (S : Unbounded_String) is
   begin
      Put_Line ("String: '" & To_String (S) & "'");
      Put_Line ("String Length: " & Integer'Image (Length (S)));
   end Display_String_Info;
begin
   S1 := To_Unbounded_String ("Hello");
   --  Or: S1 := Null_Unbounded_String & "Hello";
   Display_String_Info (S1);

   S2 := To_Unbounded_String ("Hello World");
   Display_String_Info (S2);

   --  Longer than anything before it, and nothing has to be told what to do about that.
   S1 := To_Unbounded_String ("Something longer to say here...");
   Display_String_Info (S1);

   --  Ada.Strings.Unbounded has its own Index, Count, Trim, Slice and so on, taking and
   --  returning Unbounded_String -- the Ada.Strings.Fixed operations, for this type.
   Put_Line ("Index of 'longer': " & Natural'Image (Index (S1, "longer")));
   Put_Line ("Trimmed: '"
             & To_String (Trim (To_Unbounded_String ("   padded   "), Ada.Strings.Both))
             & "'");
   Put_Line ("Slice: '" & Slice (S1, 1, 9) & "'");
end Show_Unbounded_String;
