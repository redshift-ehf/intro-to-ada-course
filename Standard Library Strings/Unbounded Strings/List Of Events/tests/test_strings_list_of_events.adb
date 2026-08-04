with Ada.Calendar;     use Ada.Calendar;
with Ada.Command_Line;
with Ada_Check;

with Strings_List_Of_Events.Lists;
use  Strings_List_Of_Events.Lists;

procedure Test_Strings_List_Of_Events is

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
   Ada_Check.Suite ("List of events (unbounded strings)");

   --  Nothing here names Event_Item. It cannot: the starting state has to compile, and a test
   --  written against the finished type would fail to build before the student had touched
   --  anything. So the type is checked through what it can hold, below -- a description longer
   --  than any fixed bound anyone would have picked, and an empty one.
   Ada_Check.Equal ("an empty list is just the heading", Displayed, "EVENTS LIST");

   --  The same four events as the last chapter, and the same answer.
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

   --  Lengths still differ per event and nothing is padded or cut.
   EL.Add (Time_Of (2018, 1, 1), "A considerably longer description than the other one");
   Ada_Check.Equal
     (Name     => "a long description, whole",
      Actual   => Displayed,
      Expected =>
        "EVENTS LIST" & ASCII.LF
        & "- 2018-01-01" & ASCII.LF
        & "    - New Year's Day" & ASCII.LF
        & "    - A considerably longer description than the other one" & ASCII.LF
        & "- 2018-02-16" & ASCII.LF
        & "    - Final check" & ASCII.LF
        & "    - Release" & ASCII.LF
        & "- 2018-12-03" & ASCII.LF
        & "    - Brother's birthday");

   --  An empty description is a value, not a null pointer.
   declare
      Blank : Event_List;

      function Blank_Displayed return String is
         procedure Call is
         begin
            Display (Blank);
         end Call;
      begin
         return Ada_Check.Output_Of (Call'Access);
      end Blank_Displayed;
   begin
      Blank.Add (Time_Of (2000, 1, 1), "");
      Ada_Check.Equal
        (Name     => "an empty description",
         Actual   => Blank_Displayed,
         Expected => "EVENTS LIST" & ASCII.LF & "- 2000-01-01" & ASCII.LF & "    - ");
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Strings_List_Of_Events;
