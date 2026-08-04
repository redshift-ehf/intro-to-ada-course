with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;

with Ada.Text_IO; use Ada.Text_IO;

--  A map associates a key with a value. This one is keyed by String -- an indefinite type, which
--  is why the package is Indefinite_Hashed_Maps and not Hashed_Maps.
procedure Show_Hashed_Map is

   package Integer_Hashed_Maps is new
     Ada.Containers.Indefinite_Hashed_Maps
       (Key_Type        => String,
        Element_Type    => Integer,
        Hash            => Ada.Strings.Hash,
        Equivalent_Keys => "=");

   use Integer_Hashed_Maps;

   M : Map;
begin
   M.Include ("Alice", 24);
   M.Include ("John",  40);
   M.Include ("Bob",   28);

   --  M ("Alice") reads the value for a key. A key that is not there raises Constraint_Error,
   --  so Contains comes first.
   if M.Contains ("Alice") then
      Put_Line ("Alice's age is " & Integer'Image (M ("Alice")));
   end if;

   --  The same notation assigns. Again: the key must already exist.
   M ("Alice") := 25;

   --  Key (C) gets the key at a cursor; M (C) gets the value.
   New_Line;
   Put_Line ("Name & Age:");
   for C in M.Iterate loop
      Put_Line (Key (C) & ": " & Integer'Image (M (C)));
   end loop;

   --  A hashed map has no order to report, so this program's last section is deliberately not
   --  compared against a fixed answer -- see the Ordered Maps lesson for the one that is.
   New_Line;
   Put_Line ("Ada is not in the map: " & Boolean'Image (not M.Contains ("Ada")));
end Show_Hashed_Map;
