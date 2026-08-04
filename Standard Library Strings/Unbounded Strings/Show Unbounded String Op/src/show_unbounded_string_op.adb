with Ada.Text_IO; use Ada.Text_IO;

with Ada.Strings.Unbounded;
use  Ada.Strings.Unbounded;

--  The same operations as the bounded version, and the same names, with nothing to say about
--  what will not fit.
procedure Show_Unbounded_String_Op is
   S1, S2 : Unbounded_String := Null_Unbounded_String;
begin
   S1 := S1 & "Hello";
   S2 := S2 & "Hello!";

   Append (S1, " World");
   Put_Line ("String: '" & To_String (S1) & "'");

   S1 := S1 & " " & S2;
   Put_Line ("String: '" & To_String (S1) & "'");

   --  The loop the bounded version needed a Max for.
   declare
      Built : Unbounded_String := Null_Unbounded_String;
   begin
      for I in 1 .. 12 loop
         Append (Built, Integer'Image (I * I));
      end loop;
      Put_Line ("Built: '" & To_String (Built) & "'");
      Put_Line ("Length:" & Integer'Image (Length (Built)) & ", and no maximum to check it");
   end;

   --  Unbounded_String is a private type with its own "=" and "<", so it compares and sorts and
   --  can be a key or an element of a container -- which is exactly what the last exercise in
   --  this chapter does with it.
   Put_Line ("Equal? " & Boolean'Image
             (To_Unbounded_String ("abc") = To_Unbounded_String ("abc")));
   Put_Line ("Before? " & Boolean'Image
             (To_Unbounded_String ("abc") < To_Unbounded_String ("abd")));
end Show_Unbounded_String_Op;
