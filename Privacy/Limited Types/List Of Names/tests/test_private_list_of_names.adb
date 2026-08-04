with Ada.Command_Line;
with Ada_Check;
with Private_List_Of_Names;

procedure Test_Private_List_Of_Names is
   use Private_List_Of_Names;

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
   Ada_Check.Suite ("List of Names, limited");

   Reset (L);

   --  L.Last_Valid was reachable in the Arrays chapter. It is not now; Count replaces it.
   Ada_Check.Equal ("an empty list counts nothing", Count (L), 0);

   Add (L, "John");
   Add (L, "Patricia");
   Add (L, "Josh");
   Ada_Check.Equal ("three people added", Count (L), 3);

   Ada_Check.Equal ("John starts at nought", Integer (Get (L, "John")), 0);

   Update (L, "John", 18);
   Update (L, "Patricia", 35);
   Update (L, "Josh", 53);

   Ada_Check.Equal ("John",     Integer (Get (L, "John")),     18);
   Ada_Check.Equal ("Patricia", Integer (Get (L, "Patricia")), 35);
   Ada_Check.Equal ("Josh",     Integer (Get (L, "Josh")),     53);

   Ada_Check.Equal ("a stranger is nought", Integer (Get (L, "Nobody")), 0);

   Update (L, "Nobody", 99);
   Ada_Check.Equal ("updating a stranger adds nobody", Count (L), 3);
   Ada_Check.Equal ("and leaves John alone", Integer (Get (L, "John")), 18);

   Ada_Check.Equal
     (Name     => "the whole list",
      Actual   => Displayed,
      Expected =>
        "LIST OF NAMES:" & ASCII.LF
        & "NAME: John" & ASCII.LF
        & "AGE:  18" & ASCII.LF
        & "NAME: Patricia" & ASCII.LF
        & "AGE:  35" & ASCII.LF
        & "NAME: Josh" & ASCII.LF
        & "AGE:  53");

   Reset (L);
   Ada_Check.Equal ("reset empties it", Count (L), 0);
   Ada_Check.Equal ("and displays only the heading", Displayed, "LIST OF NAMES:");

   --  Copy : People := L;
   --  ^ would not compile. People is limited, so there is no way to end up with two lists that
   --    were meant to be one.

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Private_List_Of_Names;
