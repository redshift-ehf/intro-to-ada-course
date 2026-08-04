with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Records is
   type Months is
     (January, February, March, April, May, June,
      July, August, September, October, November, December);

   --  A record composes several values into one, each with a name and a type of its own. A
   --  component may carry its own constraint, and it may carry a default.
   type Date is record
      Day   : Integer range 1 .. 31;
      Month : Months  := January;
      Year  : Integer range 1 .. 3000 := 2032;
   end record;

   Ada_Birthday : constant Date := (10, December, 1815);

   --  Month and Year take their defaults here. Day has none, so it starts as nothing in
   --  particular and is set below before anything reads it.
   Defaults : Date;
begin
   Put_Line ("Ada Lovelace was born on"
             & Integer'Image (Ada_Birthday.Day) & " "
             & Months'Image (Ada_Birthday.Month)
             & Integer'Image (Ada_Birthday.Year));

   Defaults.Day := 1;
   Put_Line ("A Date left to its defaults reads"
             & Integer'Image (Defaults.Day) & " "
             & Months'Image (Defaults.Month)
             & Integer'Image (Defaults.Year));
end Show_Records;
