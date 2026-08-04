with Ada.Text_IO;   use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

--  Ada.Real_Time has a Time type too, and it is not Ada.Calendar's. This one is a monotonic clock
--  with no notion of a date -- what you want when you are measuring or scheduling rather than
--  telling someone what day it is.
procedure Show_Real_Time is
   --  A Time_Span is an interval. Seconds, Milliseconds, Microseconds and Nanoseconds build one.
   D    : constant Time_Span := Milliseconds (500);
   Next : constant Time      := Clock + D;
begin
   --  Time_Span is not Duration, so it has to be converted before it can be printed.
   Put_Line ("Let's wait " & Duration'Image (To_Duration (D)) & " seconds...");

   --  The same statement as the last lesson, against a different clock.
   delay until Next;

   Put_Line ("Enough waiting!");

   --  Time_Span arithmetic. Nanoseconds is where the precision claim is cashed in.
   declare
      Tiny  : constant Time_Span := Nanoseconds (1);
      Total : constant Time_Span := D + Tiny * 1_000;
   begin
      Put_Line ("A microsecond over half a second:"
                & Duration'Image (To_Duration (Total)));
      Put_Line ("Time_Span_Unit is the smallest step:"
                & Duration'Image (To_Duration (Time_Span_Unit)));
   end;

   --  This clock never goes backwards. Ada.Calendar's can -- somebody may set it.
   declare
      A : constant Time := Clock;
      B : constant Time := Clock;
   begin
      Put_Line ("Monotonic: " & Boolean'Image (B >= A));
   end;
end Show_Real_Time;
