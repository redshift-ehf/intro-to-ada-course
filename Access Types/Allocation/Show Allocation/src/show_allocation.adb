with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Allocation is
   type Months is
     (January, February, March, April, May, June,
      July, August, September, October, November, December);

   type Date is record
      Day   : Integer range 1 .. 31;
      Month : Months  := January;
      Year  : Integer := 2000;
   end record;

   type Date_Acc   is access Date;
   type String_Acc is access String;

   --  `new` with just a type allocates and leaves the object at whatever defaults it has.
   Empty : constant Date_Acc := new Date;

   --  `new` with a qualified expression allocates and initialises in one step, which is almost
   --  always what you want.
   D : constant Date_Acc := new Date'(30, November, 2011);

   --  String is unconstrained, so allocating one means settling its bounds. Either say them...
   Buffer : constant String_Acc := new String (1 .. 10);

   --  ...or give it a value for them to come from.
   Msg : constant String_Acc := new String'("Hello");
begin
   Put_Line ("D is" & Integer'Image (D.Day) & " " & Months'Image (D.Month)
             & Integer'Image (D.Year));
   Put_Line ("Empty took its defaults: " & Months'Image (Empty.Month)
             & Integer'Image (Empty.Year));
   Put_Line ("Buffer is" & Integer'Image (Buffer.all'Length) & " characters");
   Put_Line ("Msg is """ & Msg.all & """");
end Show_Allocation;
