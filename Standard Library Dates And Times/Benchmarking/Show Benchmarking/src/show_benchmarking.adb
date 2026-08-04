with Ada.Text_IO;   use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

with Ada.Numerics.Generic_Elementary_Functions;

--  Two clock readings and a subtraction. That is the whole technique, and Ada.Real_Time is the
--  package to take the readings from because its clock is monotonic.
procedure Show_Benchmarking is

   procedure Sleeping_App is
   begin
      delay 0.5;
   end Sleeping_App;

   procedure Computational_Intensive_App is
      package Funcs is new
        Ada.Numerics.Generic_Elementary_Functions
          (Float_Type => Long_Long_Float);
      use Funcs;

      X : Long_Long_Float;
      pragma Volatile (X);
   begin
      for I in 0 .. 5_000_000 loop
         X := Tan (Arctan (Tan (Arctan (Tan (Arctan (0.577))))));
      end loop;
   end Computational_Intensive_App;

   procedure Time_It (Name : String; Run : access procedure) is
      Start_Time, Stop_Time : Time;
      Elapsed_Time          : Time_Span;
   begin
      Start_Time := Clock;

      Run.all;

      Stop_Time    := Clock;
      Elapsed_Time := Stop_Time - Start_Time;

      Put_Line (Name & " took"
                & Duration'Image (To_Duration (Elapsed_Time))
                & " seconds");
   end Time_It;
begin
   --  Half a second of doing nothing.
   Time_It ("waiting  ", Sleeping_App'Access);

   --  And some arithmetic, which takes about as long but for the opposite reason.
   Time_It ("computing", Computational_Intensive_App'Access);
end Show_Benchmarking;
