with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Derived_Types is
   type Position is range 0 .. 1_000;

   --  A derived type is a new type with the same structure as the one it comes from, and it
   --  inherits that type's operations. It is not the same type.
   type Offset is new Position;

   --  A derived type may narrow the range on the way.
   type Small_Position is new Position range 0 .. 100;

   P : constant Position       := 500;
   O : constant Offset         := 500;
   S : constant Small_Position := 50;
begin
   --  Nobody declared "+" for Offset. It arrived with the derivation, along with the literals,
   --  the comparisons and the attributes.
   Put_Line ("Offset doubled is" & Offset'Image (O + O));

   --  Crossing between them still takes an explicit conversion, exactly as between any two
   --  types. Being derived from Position does not make an Offset a Position.
   Put_Line ("P + O is" & Position'Image (P + Position (O)));

   Put_Line ("Small_Position runs" & Small_Position'Image (Small_Position'First)
             & " .." & Small_Position'Image (Small_Position'Last)
             & " and holds" & Small_Position'Image (S));
end Show_Derived_Types;
