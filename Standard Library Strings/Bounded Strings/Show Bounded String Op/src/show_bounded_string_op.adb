with Ada.Strings;         use Ada.Strings;
with Ada.Strings.Bounded;
with Ada.Text_IO;         use Ada.Text_IO;

--  Building a bounded string up, rather than assigning it whole.
procedure Show_Bounded_String_Op is
   package B_Str is new
     Ada.Strings.Bounded.Generic_Bounded_Length (Max => 30);
   use B_Str;

   S1, S2 : Bounded_String;
begin
   S1 := To_Bounded_String ("Hello");
   --  Or: S1 := Null_Bounded_String & "Hello";

   Append (S1, " World");
   --  Append takes a truncation mode too: Append (S1, " World", Right);

   Put_Line ("String: '" & To_String (S1) & "'");

   S2 := To_Bounded_String ("Hello!");

   --  "&" is overloaded for every combination -- bounded with bounded, bounded with String,
   --  bounded with Character.
   S1 := S1 & " " & S2;
   Put_Line ("String: '" & To_String (S1) & "'");
   Put_Line ("Length:" & Integer'Image (Length (S1))
             & " of" & Integer'Image (Max_Length));

   --  Null_Bounded_String is the empty one, and the sensible starting point for a loop.
   declare
      --  Bounded_String is definite -- it has one size, whatever it is holding -- so an array of
      --  them is legal where an array of String would not be.
      Words : constant array (1 .. 3) of Bounded_String :=
        (To_Bounded_String ("one"),
         To_Bounded_String ("two"),
         To_Bounded_String ("three"));

      Built : Bounded_String := Null_Bounded_String;
   begin
      for Word of Words loop
         if Length (Built) > 0 then
            Append (Built, " ");
         end if;
         Append (Built, Word);
      end loop;
      Put_Line ("Built:  '" & To_String (Built) & "'");
   end;
end Show_Bounded_String_Op;
