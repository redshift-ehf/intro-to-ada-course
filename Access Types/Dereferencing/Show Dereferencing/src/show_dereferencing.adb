with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Dereferencing is
   type Months is
     (January, February, March, April, May, June,
      July, August, September, October, November, December);

   type Date is record
      Day   : Integer range 1 .. 31;
      Month : Months;
      Year  : Integer;
   end record;

   type Date_Acc is access Date;

   D : constant Date_Acc := new Date'(30, November, 2011);

   --  `.all` is the explicit dereference: the whole object D designates. This copies it.
   Today : constant Date := D.all;

   --  For a component the dereference is implicit. D.Day means D.all.Day, and there is no
   --  separate arrow operator to remember.
   J : constant Integer := D.Day;
begin
   Put_Line ("D.all is" & Integer'Image (Today.Day) & " " & Months'Image (Today.Month));
   Put_Line ("D.Day  is" & Integer'Image (J));

   --  Today is a copy, taken when it was declared. Changing what D designates leaves it alone.
   D.Day := 1;
   Put_Line ("after D.Day := 1, D.Day is" & Integer'Image (D.Day)
             & " and Today.Day is still" & Integer'Image (Today.Day));
end Show_Dereferencing;
