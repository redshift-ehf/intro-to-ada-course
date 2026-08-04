with Ada.Text_IO; use Ada.Text_IO;

package body Event_Manager is

   task body Manager is
      Event_ID : Natural := 0;
      Due      : Ada.Real_Time.Time;
   begin
      accept Start (ID : Natural) do
         Event_ID := ID;
      end Start;

      accept Event (At_Time : Ada.Real_Time.Time) do
         Due := At_Time;
      end Event;

      --  Outside the rendezvous, so the caller is free to set up the next manager while this
      --  one waits. All of them are waiting at once, which is the point.
      delay until Due;

      Put_Line ("Event #" & Natural'Image (Event_ID));
   end Manager;

end Event_Manager;
