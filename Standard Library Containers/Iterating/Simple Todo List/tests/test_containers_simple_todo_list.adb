with Ada.Command_Line;
with Ada.Containers;
with Ada_Check;
with Containers_Simple_Todo_List;

procedure Test_Containers_Simple_Todo_List is
   use Containers_Simple_Todo_List;
   use type Ada.Containers.Count_Type;

   L : Todo_List;

   function Displayed return String is
      procedure Call is
      begin
         Display (L);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Displayed;

   function Adding (Item : String) return String is
      procedure Call is
      begin
         Add (L, Item);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Adding;
begin
   Ada_Check.Suite ("Simple todo list (vectors)");

   Ada_Check.Equal ("an empty list is just the heading", Displayed, "TO-DO LIST");

   Ada_Check.Equal ("adding says nothing", Adding ("Buy milk"), "");
   Ada_Check.Equal ("one item", Displayed, "TO-DO LIST" & ASCII.LF & "Buy milk");
   Ada_Check.Check ("and the vector holds it", L.Length = 1);

   Ada_Check.Equal ("still nothing", Adding ("Buy tea"), "");
   Ada_Check.Equal ("still nothing again", Adding ("Buy present"), "");

   Ada_Check.Equal
     (Name     => "three items, in the order they went in",
      Actual   => Displayed,
      Expected =>
        "TO-DO LIST" & ASCII.LF
        & "Buy milk" & ASCII.LF
        & "Buy tea" & ASCII.LF
        & "Buy present");

   --  The array version had a Max of 3 and refused a fourth item. This one has no Max, and that
   --  difference is the whole reason the exercise is worth doing twice.
   Ada_Check.Equal ("a fourth item is accepted", Adding ("Buy tickets"), "");
   Ada_Check.Check ("and the vector grew", L.Length = 4);

   --  Items are allocated per entry, so lengths differ and none is padded or cut.
   Ada_Check.Equal ("nothing padded", Adding ("Pay electricity bill"), "");
   Ada_Check.Equal
     (Name     => "a longer item, whole",
      Actual   => Displayed,
      Expected =>
        "TO-DO LIST" & ASCII.LF
        & "Buy milk" & ASCII.LF
        & "Buy tea" & ASCII.LF
        & "Buy present" & ASCII.LF
        & "Buy tickets" & ASCII.LF
        & "Pay electricity bill");

   --  The rest of the lab's list, to make sure nothing gives out at eleven.
   Ada_Check.Equal ("adding the sixth",   Adding ("Schedule dentist appointment"), "");
   Ada_Check.Equal ("adding the seventh", Adding ("Call sister"), "");
   Ada_Check.Equal ("adding the eighth",  Adding ("Revise spreasheet"), "");
   Ada_Check.Equal ("adding the ninth",   Adding ("Edit entry page"), "");
   Ada_Check.Equal ("adding the tenth",   Adding ("Select new design"), "");
   Ada_Check.Equal ("adding the eleventh", Adding ("Create upgrade plan"), "");

   Ada_Check.Check ("eleven items", L.Length = 11);
   Ada_Check.Equal
     (Name     => "the whole list",
      Actual   => Displayed,
      Expected =>
        "TO-DO LIST" & ASCII.LF
        & "Buy milk" & ASCII.LF
        & "Buy tea" & ASCII.LF
        & "Buy present" & ASCII.LF
        & "Buy tickets" & ASCII.LF
        & "Pay electricity bill" & ASCII.LF
        & "Schedule dentist appointment" & ASCII.LF
        & "Call sister" & ASCII.LF
        & "Revise spreasheet" & ASCII.LF
        & "Edit entry page" & ASCII.LF
        & "Select new design" & ASCII.LF
        & "Create upgrade plan");

   --  A second list is independent of the first: the vector is a value, not a shared handle.
   declare
      Other : Todo_List;

      function Other_Displayed return String is
         procedure Call is
         begin
            Display (Other);
         end Call;
      begin
         return Ada_Check.Output_Of (Call'Access);
      end Other_Displayed;
   begin
      Add (Other, "Only this");
      Ada_Check.Equal ("a second list starts empty and stays its own",
                       Other_Displayed, "TO-DO LIST" & ASCII.LF & "Only this");
      Ada_Check.Check ("the first is untouched", L.Length = 11);
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Containers_Simple_Todo_List;
