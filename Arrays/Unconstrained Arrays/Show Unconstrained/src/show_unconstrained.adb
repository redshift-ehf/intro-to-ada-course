with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Unconstrained is
   type Days is (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);

   --  `range <>` says: indexed by Days, with the bounds settled later. The type itself does not
   --  say how long its values are.
   type Workload_Type is array (Days range <>) of Natural;

   --  So the bounds are given when the object is created, and they are fixed from then on.
   Workload : constant Workload_Type (Monday .. Friday) :=
     (Friday => 7, others => 8);
begin
   for I in Workload'Range loop
      Put_Line (Days'Image (I) & ":" & Natural'Image (Workload (I)));
   end loop;

   Put_Line ("that is" & Integer'Image (Workload'Length) & " days");
end Show_Unconstrained;
