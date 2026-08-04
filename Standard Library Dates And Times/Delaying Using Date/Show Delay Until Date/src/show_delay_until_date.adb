with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Calendar; use Ada.Calendar;

with Ada.Calendar.Formatting;
use  Ada.Calendar.Formatting;

with Ada.Calendar.Time_Zones;
use  Ada.Calendar.Time_Zones;

--  `delay until` takes an absolute Time, which is exactly what Ada.Calendar provides. The Tasking
--  chapter used it with Ada.Real_Time; this is the same statement against a date on a calendar.
procedure Show_Delay_Until_Date is
   TZ : constant Time_Offset := UTC_Time_Offset;

   --  Time_Of, the long way: every component named, and a time zone.
   Next : constant Time :=
     Ada.Calendar.Formatting.Time_Of
       (Year        => 2018,
        Month       => 5,
        Day         => 1,
        Hour        => 15,
        Minute      => 0,
        Second      => 0,
        Sub_Second  => 0.0,
        Leap_Second => False,
        Time_Zone   => TZ);

   --  And the short way: parsed from a String, in the same zone.
   Same : constant Time :=
     Ada.Calendar.Formatting.Value ("2018-05-01 15:00:00.00", TZ);
begin
   Put_Line ("Let's wait until...");
   Put_Line (Image (Next, True, TZ));

   --  The date is in the past, so this returns at once. Give it a future one and the program
   --  would stop here until that moment arrived.
   delay until Next;

   Put_Line ("Enough waiting!");

   Put_Line ("Both ways agree: " & Boolean'Image (Next = Same));
   Put_Line ("UTC offset in minutes:" & Time_Offset'Image (TZ));

   --  Relative, rather than absolute: now, plus a Duration.
   declare
      D        : constant Duration := 0.5;
      Deadline : constant Time := Clock + D;
   begin
      Put_Line ("Let's wait " & Duration'Image (D) & " seconds...");
      delay until Deadline;
      Put_Line ("Enough waiting!");
   end;
end Show_Delay_Until_Date;
