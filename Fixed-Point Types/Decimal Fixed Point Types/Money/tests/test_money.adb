with Ada.Command_Line;
with Ada_Check;
with Money;

procedure Test_Money is
   use Money;
begin
   Ada_Check.Suite ("Money");

   --  The reason this type exists. In binary floating point 0.1 + 0.2 is not 0.3; here it is,
   --  exactly, and the comparison is on the text so there is no tolerance hiding anything.
   Ada_Check.Equal ("0.10 + 0.20 is exactly 0.30", Image (Add (0.10, 0.20)), "0.30");
   Ada_Check.Equal ("10.50 + 5.25",                Image (Add (10.50, 5.25)), "15.75");
   Ada_Check.Equal ("adding nothing",              Image (Add (7.77, 0.00)), "7.77");

   Ada_Check.Equal ("2.50 four times", Image (Times (2.50, 4)), "10.00");
   Ada_Check.Equal ("0.01 a hundred times", Image (Times (0.01, 100)), "1.00");
   Ada_Check.Equal ("anything no times", Image (Times (9.99, 0)), "0.00");

   --  Splitting three ways cannot come out even, and the missing cent must be accounted for
   --  rather than quietly lost.
   Ada_Check.Equal ("10.00 split three ways",  Image (Split (10.00, 3)), "3.33");
   Ada_Check.Equal ("and the cent left over",  Image (Remainder (10.00, 3)), "0.01");
   Ada_Check.Equal ("10.00 split four ways",   Image (Split (10.00, 4)), "2.50");
   Ada_Check.Equal ("with nothing left over",  Image (Remainder (10.00, 4)), "0.00");

   --  Three shares plus the remainder is the whole amount, which is the property that matters.
   Ada_Check.Equal
     ("the parts add back up to the whole",
      Image (Add (Times (Split (10.00, 3), 3), Remainder (10.00, 3))),
      "10.00");

   Ada_Check.Equal ("Image has no leading space", Image (1.00), "1.00");
   Ada_Check.Equal ("and keeps both decimals",    Image (5.00), "5.00");
   Ada_Check.Equal ("negative amounts too",       Image (Add (1.00, -3.50)), "-2.50");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Money;
