with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Calendar; use Ada.Calendar;

with Ada.Calendar.Formatting;
use  Ada.Calendar.Formatting;

--  Ada.Calendar is the everyday half of dates and times: a Time type that means a date and a time
--  of day, a Clock that reads it, and Split to take it apart.
procedure Show_Calendar is
   Now : constant Time := Clock;

   Now_Year    : Year_Number;
   Now_Month   : Month_Number;
   Now_Day     : Day_Number;
   Now_Seconds : Day_Duration;
begin
   --  Image, from Ada.Calendar.Formatting, is the whole thing as YYYY-MM-DD HH:MM:SS.
   Put_Line ("Current time: " & Image (Now));

   --  Split is the other direction: one Time out into its components, through out parameters.
   Split (Now, Now_Year, Now_Month, Now_Day, Now_Seconds);

   Put_Line ("Current year  is: " & Year_Number'Image (Now_Year));
   Put_Line ("Current month is: " & Month_Number'Image (Now_Month));
   Put_Line ("Current day   is: " & Day_Number'Image (Now_Day));

   --  Day_Duration is seconds since midnight, and it is a fixed-point type -- so this is a count
   --  of seconds with a fraction, not a count of ticks.
   Put_Line ("Seconds today is: " & Duration'Image (Now_Seconds));

   --  Time_Of goes back the other way. These are subtypes with real ranges: Month_Number is
   --  1 .. 12, so Time_Of (2018, 13, 1) does not compile, and a computed 13 raises
   --  Constraint_Error rather than rolling over into next year.
   --
   --  Both packages declare a Time_Of and a Year, with different profiles, and both are `use`d
   --  here -- so these two calls have to say which one they mean. That is not a design fault:
   --  Formatting's versions take an hour, a minute and a time zone, and they are a different
   --  operation from Calendar's.
   declare
      Fixed : constant Time := Ada.Calendar.Time_Of (2018, 5, 1);
   begin
      Put_Line ("A fixed date:     " & Image (Fixed));
      Put_Line ("Its year:         " & Year_Number'Image (Ada.Calendar.Year (Fixed)));
   end;

   --  Time supports arithmetic with Duration, and subtraction between two Times gives one.
   declare
      Tomorrow : constant Time     := Now + 86_400.0;
      Gap      : constant Duration := Tomorrow - Now;
   begin
      Put_Line ("Tomorrow:         " & Image (Tomorrow));
      Put_Line ("A day in seconds: " & Duration'Image (Gap));
      Put_Line ("Later? " & Boolean'Image (Tomorrow > Now));
   end;
end Show_Calendar;
