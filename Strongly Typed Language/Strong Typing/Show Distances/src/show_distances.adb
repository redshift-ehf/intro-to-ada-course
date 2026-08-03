with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Distances is
   --  Two types, both Float underneath, and the compiler treats them as having nothing to do
   --  with each other. That is what "strongly typed" buys: a distance in metres cannot be
   --  handed to something expecting feet by accident, however similar they look.
   type Meters is new Float;
   type Feet   is new Float;

   function To_Feet (M : Meters) return Feet is
     (Feet (Float (M) * 3.280_84));

   Height : constant Meters := 100.0;
begin
   Put_Line (Float'Image (Float (Height)) & " m is"
             & Float'Image (Float (To_Feet (Height))) & " ft");

   --  The conversion above is written out because it has to be. Try adding
   --
   --     Wrong : constant Feet := Height;
   --
   --  and pressing Run: "expected type Feet, found type Meters". Both are Float and the
   --  compiler still refuses -- the units are the reason the types exist.
end Show_Distances;
