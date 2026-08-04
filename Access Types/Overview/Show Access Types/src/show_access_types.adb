with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Access_Types is
   type Months is
     (January, February, March, April, May, June,
      July, August, September, October, November, December);

   type Date is record
      Day   : Integer range 1 .. 31;
      Month : Months;
      Year  : Integer;
   end record;

   --  An access type designates another type. Values of it are either null or the location of a
   --  Date -- and null is the default, so an access value is never left pointing at rubbish.
   type Date_Acc is access Date;

   --  A second access type to the very same Date is still a different type. Ada names types
   --  rather than comparing their shapes, so `D2 : Date_Acc_2 := D;` does not compile.
   type Date_Acc_2 is access Date;

   D  : Date_Acc := null;
   D2 : Date_Acc_2;
begin
   Put_Line ("D starts null:  " & Boolean'Image (D = null));
   Put_Line ("D2 starts null: " & Boolean'Image (D2 = null));

   D := new Date'(30, November, 2011);

   Put_Line ("after allocating, D is null: " & Boolean'Image (D = null));
   Put_Line ("and it designates" & Integer'Image (D.Day) & " "
             & Months'Image (D.Month) & Integer'Image (D.Year));
end Show_Access_Types;
