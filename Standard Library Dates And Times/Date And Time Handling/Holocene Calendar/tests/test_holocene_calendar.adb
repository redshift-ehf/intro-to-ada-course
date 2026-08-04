with Ada.Calendar; use Ada.Calendar;
with Ada.Command_Line;
with Ada_Check;
with Holocene_Calendar;

procedure Test_Holocene_Calendar is
   use Holocene_Calendar;
begin
   Ada_Check.Suite ("Holocene calendar");

   --  The lab's own two cases.
   Ada_Check.Equal ("2012 is 12012", To_Holocene_Year (Time_Of (2012, 1, 1)), 12_012);
   Ada_Check.Equal ("2020 is 12020", To_Holocene_Year (Time_Of (2020, 1, 1)), 12_020);

   --  Ada.Calendar's Year_Number runs 1901 .. 2399, so those are the ends of what can be asked.
   Ada_Check.Equal ("the earliest year Ada.Calendar has",
                    To_Holocene_Year (Time_Of (Year_Number'First, 1, 1)), 11_901);
   Ada_Check.Equal ("and the latest",
                    To_Holocene_Year (Time_Of (Year_Number'Last, 12, 31)), 12_399);

   --  The month and the day are not part of the answer.
   Ada_Check.Equal ("December is the same year as January",
                    To_Holocene_Year (Time_Of (1999, 12, 31)),
                    To_Holocene_Year (Time_Of (1999, 1, 1)));

   --  And neither is the time of day.
   Ada_Check.Equal ("nor is the hour",
                    To_Holocene_Year (Time_Of (2000, 6, 15, 23.0 * 3600.0)), 12_000);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Holocene_Calendar;
