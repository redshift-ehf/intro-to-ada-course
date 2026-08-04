with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Selection is
   type Months is
     (January, February, March, April, May, June,
      July, August, September, October, November, December);

   type Date is record
      Day   : Integer range 1 .. 31;
      Month : Months;
      Year  : Integer range 1 .. 3000 := 2032;
   end record;

   --  Records nest, and so does the dot.
   type Event is record
      Marker   : Character;
      Occurred : Date;
   end record;

   procedure Display_Date (D : Date) is
   begin
      Put_Line ("Day:" & Integer'Image (D.Day)
                & ", Month: " & Months'Image (D.Month)
                & ", Year:" & Integer'Image (D.Year));
   end Display_Date;

   Some_Day    : Date := (1, January, 2000);
   Declaration : constant Event := ('d', (4, July, 1776));
begin
   Display_Date (Some_Day);

   --  The same notation reads a component and writes one.
   Put_Line ("Changing year...");
   Some_Day.Year := 2001;
   Display_Date (Some_Day);

   Put_Line ("Event " & Declaration.Marker & " happened in"
             & Integer'Image (Declaration.Occurred.Year));
end Show_Selection;
