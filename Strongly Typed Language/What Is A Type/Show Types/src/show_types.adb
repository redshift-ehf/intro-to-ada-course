with Ada.Text_IO; use Ada.Text_IO;

--  A type is a set of values together with the operations allowed on them. It is entirely a
--  compile-time idea: both of these are ordinary machine integers at run time, and none of the
--  checking below costs anything once the program is built.
procedure Show_Types is
   type Altitude is range 0 .. 60_000;
   type Heading  is range 0 .. 359;

   Cruise : constant Altitude := 37_000;
   Course : constant Heading  := 270;
begin
   --  'First and 'Last are attributes of the type, not values you have to remember.
   Put_Line ("Altitude runs from" & Altitude'Image (Altitude'First)
             & " to" & Altitude'Image (Altitude'Last));
   Put_Line ("Heading  runs from" & Heading'Image (Heading'First)
             & " to" & Heading'Image (Heading'Last));

   Put_Line ("Cruising at" & Altitude'Image (Cruise)
             & " on heading" & Heading'Image (Course));

   --  Both are whole numbers in a range, and both are stored the same way. They are still
   --  different types, and the compiler will not let one stand in for the other -- which is the
   --  entire subject of this chapter.
end Show_Types;
