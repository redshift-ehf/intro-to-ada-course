package body Holocene_Calendar is

   function To_Holocene_Year (T : Time) return Integer is
   begin
      --  Year (T) is Ada.Calendar's, and it is the only component this needs.
      return Year (T) + 10_000;
   end To_Holocene_Year;

end Holocene_Calendar;
