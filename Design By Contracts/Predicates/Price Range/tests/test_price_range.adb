with Ada.Command_Line;
with Ada.Assertions;
with Ada_Check;
with Price_Range;

procedure Test_Price_Range is
   use Price_Range;

   function Accepts (Value : Amount) return String is
   begin
      declare
         P : constant Price := Value;
         pragma Unreferenced (P);
      begin
         return "accepted";
      end;
   exception
      when Ada.Assertions.Assertion_Error => return "refused";
   end Accepts;
begin
   Ada_Check.Suite ("Price Range");

   Ada_Check.Equal ("a positive price",  Accepts (12.50), "accepted");
   Ada_Check.Equal ("nothing is a price", Accepts (0.00), "accepted");
   Ada_Check.Equal ("a negative price is not", Accepts (-0.01), "refused");
   Ada_Check.Equal ("nor a very negative one", Accepts (-1_000.00), "refused");

   Ada_Check.Equal ("three at 12.50", Float (Total (12.50, 3)), 37.5);
   Ada_Check.Equal ("none at all",    Float (Total (12.50, 0)), 0.0);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Price_Range;
