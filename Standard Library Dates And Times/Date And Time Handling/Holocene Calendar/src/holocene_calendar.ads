with Ada.Calendar; use Ada.Calendar;

--  The Holocene calendar counts from the start of the Holocene epoch rather than from year 1, so
--  an AD year is its Gregorian year plus 10,000. It is a rebasing, not a different calendar: the
--  months and days are unchanged.
package Holocene_Calendar is

   --  Takes the year out of a Time and returns the Holocene year for it.
   function To_Holocene_Year (T : Time) return Integer;

end Holocene_Calendar;
