with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Component_Renaming is
   type Months is
     (January, February, March, April, May, June,
      July, August, September, October, November, December);

   type Date is record
      Day   : Integer range 1 .. 31;
      Month : Months;
      Year  : Integer range 1 .. 3000 := 2032;
   end record;

   procedure Increase_Month (Some_Day : in out Date) is
      --  A renaming is not a copy. M *is* Some_Day.Month, so assigning to M assigns to the
      --  record -- which is what makes this worth doing rather than just shorter.
      M : Months  renames Some_Day.Month;
      Y : Integer renames Some_Day.Year;

      --  Subprograms rename too, attributes included.
      function Next (Value : Months) return Months renames Months'Succ;
   begin
      if M = December then
         M := January;
         Y := Y + 1;
      else
         M := Next (M);
      end if;
   end Increase_Month;

   procedure Display (Some_Day : Date) is
      M : Months  renames Some_Day.Month;
      Y : Integer renames Some_Day.Year;
   begin
      Put_Line ("Month: " & Months'Image (M) & ", Year:" & Integer'Image (Y));
   end Display;

   D : Date := (1, December, 2000);
begin
   Display (D);
   Put_Line ("Increasing month...");
   Increase_Month (D);
   Display (D);
end Show_Component_Renaming;
