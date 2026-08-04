with Ada.Calendar;            use Ada.Calendar;
with Ada.Command_Line;
with Ada_Check;
with List_Of_Events.Lists;    use List_Of_Events.Lists;

procedure Test_List_Of_Events is

   EL : Event_List;

   function Displayed return String is
      procedure Call is
      begin
         Display (EL);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Displayed;
begin
   Ada_Check.Suite ("List of events");

   Ada_Check.Equal ("an empty list is just the heading", Displayed, "EVENTS LIST");

   --  The lab's own case: four events, added out of order, two of them on one date.
   EL.Add (Time_Of (2018, 2, 16), "Final check");
   EL.Add (Time_Of (2018, 2, 16), "Release");
   EL.Add (Time_Of (2018, 12, 3), "Brother's birthday");
   EL.Add (Time_Of (2018, 1, 1),  "New Year's Day");

   Ada_Check.Equal
     (Name     => "dates in order, events in the order they went in",
      Actual   => Displayed,
      Expected =>
        "EVENTS LIST" & ASCII.LF
        & "- 2018-01-01" & ASCII.LF
        & "    - New Year's Day" & ASCII.LF
        & "- 2018-02-16" & ASCII.LF
        & "    - Final check" & ASCII.LF
        & "    - Release" & ASCII.LF
        & "- 2018-12-03" & ASCII.LF
        & "    - Brother's birthday");

   --  A date already present takes another event rather than replacing what is there.
   EL.Add (Time_Of (2018, 1, 1), "Second thing that day");
   Ada_Check.Equal
     (Name     => "a second event on a date already listed",
      Actual   => Displayed,
      Expected =>
        "EVENTS LIST" & ASCII.LF
        & "- 2018-01-01" & ASCII.LF
        & "    - New Year's Day" & ASCII.LF
        & "    - Second thing that day" & ASCII.LF
        & "- 2018-02-16" & ASCII.LF
        & "    - Final check" & ASCII.LF
        & "    - Release" & ASCII.LF
        & "- 2018-12-03" & ASCII.LF
        & "    - Brother's birthday");

   --  A date earlier than everything already there still sorts to the front.
   declare
      Fresh : Event_List;

      function Fresh_Displayed return String is
         procedure Call is
         begin
            Display (Fresh);
         end Call;
      begin
         return Ada_Check.Output_Of (Call'Access);
      end Fresh_Displayed;
   begin
      Fresh.Add (Time_Of (2020, 6, 1), "Later");
      Fresh.Add (Time_Of (1999, 1, 2), "Much earlier");

      Ada_Check.Equal
        (Name     => "a new earliest date goes first",
         Actual   => Fresh_Displayed,
         Expected =>
           "EVENTS LIST" & ASCII.LF
           & "- 1999-01-02" & ASCII.LF
           & "    - Much earlier" & ASCII.LF
           & "- 2020-06-01" & ASCII.LF
           & "    - Later");

      --  Descriptions are allocated per event, so lengths differ and none is padded or cut.
      Fresh.Add (Time_Of (1999, 1, 2), "A considerably longer description than the other one");
      Ada_Check.Equal
        (Name     => "a long description, whole",
         Actual   => Fresh_Displayed,
         Expected =>
           "EVENTS LIST" & ASCII.LF
           & "- 1999-01-02" & ASCII.LF
           & "    - Much earlier" & ASCII.LF
           & "    - A considerably longer description than the other one" & ASCII.LF
           & "- 2020-06-01" & ASCII.LF
           & "    - Later");
   end;

   --  Two Times on the same day but at different hours are different keys. The dates print the
   --  same; the events do not merge.
   declare
      Hours : Event_List;

      function Hours_Displayed return String is
         procedure Call is
         begin
            Display (Hours);
         end Call;
      begin
         return Ada_Check.Output_Of (Call'Access);
      end Hours_Displayed;
   begin
      Hours.Add (Time_Of (2021, 3, 4, 9.0 * 3600.0),  "Morning");
      Hours.Add (Time_Of (2021, 3, 4, 17.0 * 3600.0), "Evening");

      Ada_Check.Equal
        (Name     => "the key is a Time, not a date",
         Actual   => Hours_Displayed,
         Expected =>
           "EVENTS LIST" & ASCII.LF
           & "- 2021-03-04" & ASCII.LF
           & "    - Morning" & ASCII.LF
           & "- 2021-03-04" & ASCII.LF
           & "    - Evening");
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_List_Of_Events;
