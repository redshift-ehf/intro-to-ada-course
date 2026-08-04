with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Extension is

   --  A subprogram is a *primitive* of a type when it is declared in the same package as the
   --  type. That is the only rule, and it is what derivation inherits.
   package Week is
      type Days is (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);

      procedure Print_Day (D : Days);
   end Week;

   package body Week is
      procedure Print_Day (D : Days) is
      begin
         Put_Line (Days'Image (D));
      end Print_Day;
   end Week;

   use Week;

   --  Derived from Days, so Print_Day comes with it. Nothing was written to make that happen;
   --  it is as though `procedure Print_Day (D : Weekend_Days)` had been declared with the same
   --  body.
   type Weekend_Days is new Days range Saturday .. Sunday;

   Sat : constant Weekend_Days := Saturday;
begin
   Print_Day (Sat);

   --  This is the derivation from Strongly Typed Language, seen again for what it inherits
   --  rather than for the new type it makes. It goes only so far: no new components can be
   --  added, and which body runs is settled at compile time. Both of those need `tagged`.
end Show_Extension;
