with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Generics is

   --  `generic` introduces a template, not a subprogram. What follows it are the formal
   --  parameters -- here a type -- and then the thing being made generic.
   generic
      type T is private;
   procedure Report (Value : T);

   --  The body does not repeat `generic`. It is an ordinary body that happens to use T.
   procedure Report (Value : T) is
      pragma Unreferenced (Value);
   begin
      Put_Line ("reported one value of some type");
   end Report;

   --  None of that is code yet. This is what makes code:
   procedure Report_Integer   is new Report (T => Integer);
   procedure Report_Character is new Report (T => Character);
begin
   Report_Integer (42);
   Report_Character ('a');

   --  Report (42);
   --  ^ does not compile. A generic is not callable; only an instance is.
end Show_Generics;
