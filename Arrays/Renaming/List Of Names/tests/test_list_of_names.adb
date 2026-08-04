with Ada.Command_Line;
with Ada_Check;
with List_Of_Names;

procedure Test_List_Of_Names is
   use List_Of_Names;

   L : People;

   function Displayed return String is
      procedure Call is
      begin
         Display (L);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Displayed;
begin
   Ada_Check.Suite ("List of Names");

   Reset (L);
   Ada_Check.Equal ("an empty list has nothing valid", L.Last_Valid, 0);

   Add (L, "John");
   Add (L, "Patricia");
   Add (L, "Josh");
   Ada_Check.Equal ("three people added", L.Last_Valid, 3);

   --  Everyone starts at nought, so Get must find them before Update has run.
   Ada_Check.Equal ("John starts at nought", Integer (Get (L, "John")), 0);

   Update (L, "John", 18);
   Update (L, "Patricia", 35);
   Update (L, "Josh", 53);

   Ada_Check.Equal ("John",     Integer (Get (L, "John")),     18);
   Ada_Check.Equal ("Patricia", Integer (Get (L, "Patricia")), 35);
   Ada_Check.Equal ("Josh",     Integer (Get (L, "Josh")),     53);

   --  Somebody who was never added.
   Ada_Check.Equal ("a stranger is nought", Integer (Get (L, "Nobody")), 0);

   --  Updating a stranger must not add them, and must not disturb anyone else.
   Update (L, "Nobody", 99);
   Ada_Check.Equal ("a stranger is still not on the list", L.Last_Valid, 3);
   Ada_Check.Equal ("and John is untouched", Integer (Get (L, "John")), 18);

   Ada_Check.Equal
     (Name     => "the whole list, in the order it was built",
      Actual   => Displayed,
      Expected =>
        "LIST OF NAMES:" & ASCII.LF
        & "NAME: John" & ASCII.LF
        & "AGE:  18" & ASCII.LF
        & "NAME: Patricia" & ASCII.LF
        & "AGE:  35" & ASCII.LF
        & "NAME: Josh" & ASCII.LF
        & "AGE:  53");

   --  Reset does not have to erase anything, only forget it.
   Reset (L);
   Ada_Check.Equal ("reset empties the list", L.Last_Valid, 0);
   Ada_Check.Equal ("and displays nothing but the heading",
                    Displayed, "LIST OF NAMES:");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_List_Of_Names;
