with Ada.Command_Line;
with Ada_Check;
with Price_List;

procedure Test_Price_List is
   use Price_List;

   P : Prices (10);

   function Displayed return String is
      procedure Call is
      begin
         Display (P);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Displayed;
begin
   Ada_Check.Suite ("Price list");

   Reset (P);
   Ada_Check.Equal ("an empty list counts nothing", Count (P), 0);
   Ada_Check.Equal ("and displays only the heading", Displayed, "PRICE LIST");

   Add (P, 1.45);
   Add (P, 2.37);
   Add (P, 3.21);
   Ada_Check.Equal ("three prices added", Count (P), 3);

   --  Get returns a variant record. Reading Price when Ok is False would raise, so the Ok is
   --  checked first -- which is the shape all variant-record code takes.
   declare
      R : constant Price_Result := Get (P, 2);
   begin
      Ada_Check.Check ("the second price is there", R.Ok);
      if R.Ok then
         Ada_Check.Equal ("and it is 2.37", Price_Type'Image (R.Price), " 2.37");
      end if;
   end;

   declare
      R : constant Price_Result := Get (P, 4);
   begin
      Ada_Check.Check ("a fourth price is not there", not R.Ok);
   end;

   declare
      R : constant Price_Result := Get (P, 1);
   begin
      Ada_Check.Check ("the first is there", R.Ok);
      if R.Ok then
         Ada_Check.Equal ("and it is 1.45", Price_Type'Image (R.Price), " 1.45");
      end if;
   end;

   Ada_Check.Equal
     (Name     => "the list, one price per line",
      Actual   => Displayed,
      Expected =>
        "PRICE LIST" & ASCII.LF
        & " 1.45" & ASCII.LF
        & " 2.37" & ASCII.LF
        & " 3.21");

   --  Decimal fixed point, so the total is exact rather than nearly right.
   Ada_Check.Equal ("1.45 + 2.37 + 3.21", Price_Type'Image (1.45 + 2.37 + 3.21), " 7.03");

   Reset (P);
   Ada_Check.Equal ("reset empties it", Count (P), 0);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Price_List;
