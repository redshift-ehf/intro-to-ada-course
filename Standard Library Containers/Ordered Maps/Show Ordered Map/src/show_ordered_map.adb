with Ada.Containers.Indefinite_Ordered_Maps;

with Ada.Text_IO; use Ada.Text_IO;

--  The same program as the hashed map, with two lines changed. That is the point of it.
procedure Show_Ordered_Map is

   package Integer_Ordered_Maps is new
     Ada.Containers.Indefinite_Ordered_Maps
       (Key_Type     => String,
        Element_Type => Integer);

   use Integer_Ordered_Maps;

   M : Map;
begin
   M.Include ("Alice", 24);
   M.Include ("John",  40);
   M.Include ("Bob",   28);

   if M.Contains ("Alice") then
      Put_Line ("Alice's age is " & Integer'Image (M ("Alice")));
   end if;

   M ("Alice") := 25;

   --  Alice, Bob, John -- every time, on every machine. The hashed version makes no such promise.
   New_Line;
   Put_Line ("Name & Age:");
   for C in M.Iterate loop
      Put_Line (Key (C) & ": " & Integer'Image (M (C)));
   end loop;

   --  Ordering also means there is a first and a last.
   New_Line;
   Put_Line ("First key: " & Key (M.First));
   Put_Line ("Last key:  " & Key (M.Last));
end Show_Ordered_Map;
