with Ada.Command_Line;
with Ada_Check;
with Product_Info;

procedure Test_Product_Info is
   use Product_Info;

   Items : constant Product_Infos (1 .. 5) :=
     ((Units =>  1, Price =>  0.5),
      (Units =>  2, Price => 10.0),
      (Units =>  5, Price => 40.0),
      (Units => 10, Price => 10.0),
      (Units => 10, Price => 20.0));

   --  Which Total is meant is settled by what the result is declared to be. Neither of these
   --  calls says anything the other does not.
   Each  : constant Currency_Array := Total (Items);
   Grand : constant Currency       := Total (Items);

   Written : Currency_Array (Items'Range);
begin
   Ada_Check.Suite ("Product info");

   Ada_Check.Equal ("one line per product", Each'Length, 5);
   Ada_Check.Equal ("1 at 0.50",   Float (Each (1)),   0.5);
   Ada_Check.Equal ("2 at 10.00",  Float (Each (2)),  20.0);
   Ada_Check.Equal ("5 at 40.00",  Float (Each (3)), 200.0);
   Ada_Check.Equal ("10 at 10.00", Float (Each (4)), 100.0);
   Ada_Check.Equal ("10 at 20.00", Float (Each (5)), 200.0);

   Ada_Check.Equal ("everything together", Float (Grand), 520.5, Tolerance => 0.01);

   --  The procedure must agree with the function; they are the same sum written twice.
   Total (Items, Written);
   Ada_Check.Equal ("the procedure agrees, first",  Float (Written (1)), Float (Each (1)));
   Ada_Check.Equal ("the procedure agrees, middle", Float (Written (3)), Float (Each (3)));
   Ada_Check.Equal ("the procedure agrees, last",   Float (Written (5)), Float (Each (5)));

   --  Nothing above assumes an array starts at 1, so an array that does not must also work.
   declare
      Offset : constant Product_Infos (10 .. 11) :=
        ((Units => 3, Price => 2.0), (Units => 4, Price => 0.5));
      Totals : constant Currency_Array := Total (Offset);
   begin
      Ada_Check.Equal ("bounds are carried over", Totals'First, 10);
      Ada_Check.Equal ("3 at 2.00", Float (Totals (10)), 6.0);
      Ada_Check.Equal ("4 at 0.50", Float (Totals (11)), 2.0);
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Product_Info;
