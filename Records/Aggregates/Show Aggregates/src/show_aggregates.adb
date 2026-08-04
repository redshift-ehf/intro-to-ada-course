with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Aggregates is
   type Months is
     (January, February, March, April, May, June,
      July, August, September, October, November, December);

   type Date is record
      Day   : Integer range 1 .. 31;
      Month : Months;
      Year  : Integer range 1 .. 3000 := 2032;
   end record;

   --  Positional: the components in the order they were declared.
   Ada_Birthday : constant Date := (10, December, 1815);

   --  Named: any order you like, and each value says what it is for.
   Leap_Day : constant Date := (Day   => 29,
                                Month => February,
                                Year  => 2020);

   --  The two may be mixed, so long as no positional value follows a named one.
   Moon_Landing : constant Date := (20, Month => July, Year => 1969);

   --  `<>` means "whatever this component's default is".
   New_Years_Day : constant Date := (Day => 1, Month => January, Year => <>);

   procedure Display (D : Date) is
   begin
      Put_Line (Integer'Image (D.Day) & " " & Months'Image (D.Month)
                & Integer'Image (D.Year));
   end Display;
begin
   Display (Ada_Birthday);
   Display (Leap_Day);
   Display (Moon_Landing);
   Display (New_Years_Day);
end Show_Aggregates;
