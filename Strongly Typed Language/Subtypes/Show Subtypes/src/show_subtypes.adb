with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Subtypes is
   type Position is range 0 .. 1_000;

   --  A subtype is not a new type. It is the same type carrying a constraint, so no conversion
   --  is needed in either direction -- only a check, at run time, on the way in.
   subtype Near is Position range 0 .. 100;

   --  With no constraint at all, a subtype is simply another name for the type.
   subtype Distance is Position;

   P : Position := 500;
   N : Near     := 50;
   D : Distance := 0;
begin
   Put_Line ("Near runs" & Near'Image (Near'First) & " .." & Near'Image (Near'Last));

   --  Every one of these is a Position, so every one of these assignments is allowed as written.
   --  Contrast Show_Derived_Types, where the same thing needed a conversion.
   D := P;
   P := N;
   N := P;

   Put_Line ("P =" & Position'Image (P)
             & ", N =" & Near'Image (N)
             & ", D =" & Distance'Image (D));

   --  The check is real, though. Try setting P to 500 just before `N := P;` above and pressing
   --  Run: it compiles, and raises Constraint_Error when it gets there.

   --  Natural and Positive are exactly this, declared for you in Standard.
   Put_Line ("Natural  is Integer range" & Integer'Image (Natural'First)
             & " .." & Integer'Image (Natural'Last));
   Put_Line ("Positive is Integer range" & Integer'Image (Positive'First)
             & " .." & Integer'Image (Positive'Last));
end Show_Subtypes;
