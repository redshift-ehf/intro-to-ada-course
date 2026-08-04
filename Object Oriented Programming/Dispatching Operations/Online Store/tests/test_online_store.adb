with Ada.Command_Line;
with Ada_Check;
with Online_Store;

procedure Test_Online_Store is
   use Online_Store;

   --  A classwide access type, so one array can hold both kinds. Exactly the arrangement the
   --  Classwide Access Types lesson describes, doing real work.
   type Member_Ref is access Member'Class;

   Members : constant array (1 .. 4) of Member_Ref :=
     (1 => new Member      '(Start => 2010),
      2 => new Full_Member '(Start => 1998, Discount => 0.10),
      3 => new Full_Member '(Start => 1987, Discount => 0.20),
      4 => new Member      '(Start => 2013));

   Prices : constant array (1 .. 4) of Amount := (250.00, 160.00, 400.00, 110.00);
begin
   Ada_Check.Suite ("Online Store");

   --  Every call below goes through Member'Class, so the tag decides which body runs. Nothing
   --  in this loop asks what kind of member it is holding.
   Ada_Check.Equal ("member 1 is an associate", Members (1).Get_Status, "Associate Member");
   Ada_Check.Equal ("member 2 is full",         Members (2).Get_Status, "Full Member");
   Ada_Check.Equal ("member 3 is full",         Members (3).Get_Status, "Full Member");
   Ada_Check.Equal ("member 4 is an associate", Members (4).Get_Status, "Associate Member");

   Ada_Check.Equal ("an associate pays the price",
                    Amount'Image (Members (1).Get_Price (Prices (1))), " 250.00");
   Ada_Check.Equal ("a full member at 10 per cent off",
                    Amount'Image (Members (2).Get_Price (Prices (2))), " 144.00");
   Ada_Check.Equal ("a full member at 20 per cent off",
                    Amount'Image (Members (3).Get_Price (Prices (3))), " 320.00");
   Ada_Check.Equal ("and another associate",
                    Amount'Image (Members (4).Get_Price (Prices (4))), " 110.00");

   Ada_Check.Equal ("joining years are kept", Integer (Members (2).Start), 1998);

   --  A full member with no discount pays full price, which is worth checking because it is
   --  the case where the two bodies happen to agree.
   declare
      Undiscounted : constant Full_Member := (Start => 2020, Discount => 0.00);
      Wide : constant Member'Class := Undiscounted;
   begin
      Ada_Check.Equal ("no discount, full price",
                       Amount'Image (Wide.Get_Price (99.99)), " 99.99");
      Ada_Check.Equal ("and still a full member", Wide.Get_Status, "Full Member");
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Online_Store;
