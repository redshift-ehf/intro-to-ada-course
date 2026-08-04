with Ada.Command_Line;
with Ada_Check;
with Simple_Todo_List;

procedure Test_Simple_Todo_List is
   use Simple_Todo_List;

   L : Todo_List (3);

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
   Ada_Check.Suite ("Simple todo list");

   Ada_Check.Equal ("an empty list is just the heading", Displayed, "TO-DO LIST");

   Ada_Check.Equal ("adding says nothing", Adding ("Buy milk"), "");
   Ada_Check.Equal ("one item", Displayed, "TO-DO LIST" & ASCII.LF & "Buy milk");

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

   --  Max is 3, so the fourth has nowhere to go.
   Ada_Check.Equal ("a fourth item is refused",
                    Adding ("Buy tickets"), "ERROR: list is full!");
   Ada_Check.Equal ("and the list is unchanged", L.Last, 3);
   Ada_Check.Equal
     (Name     => "with nothing appended",
      Actual   => Displayed,
      Expected =>
        "TO-DO LIST" & ASCII.LF
        & "Buy milk" & ASCII.LF
        & "Buy tea" & ASCII.LF
        & "Buy present");

   --  Items are allocated per entry, so lengths differ and none is padded or cut.
   Ada_Check.Equal ("the first item kept its length", L.Items (1).all'Length, 8);
   Ada_Check.Equal ("and the third kept its own",     L.Items (3).all'Length, 11);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Simple_Todo_List;
