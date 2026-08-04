with Ada.Command_Line;
with Ada.Text_IO;
with Ada_Check;
with Generic_List;

procedure Test_Generic_List is

   type Int_Array is array (Positive range <>) of Integer;

   --  The storage the instance will write into. Declared here, before the instantiation, which
   --  is what an `in out` formal object requires.
   Numbers : Int_Array (1 .. 3);
   Count   : Natural := 0;

   procedure Put_Int (I : Integer) is
   begin
      Ada.Text_IO.Put (Integer'Image (I));
   end Put_Int;

   package Int_List is new Generic_List
     (Item       => Integer,
      Items      => Int_Array,
      Name       => "List of integers",
      List_Array => Numbers,
      Last       => Count,
      Put        => Put_Int);

   Added : Boolean;

   function Displayed return String is
      procedure Call is
      begin
         Int_List.Display;
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Displayed;
begin
   Ada_Check.Suite ("Generic list");

   Int_List.Init;
   Ada_Check.Equal ("an empty list", Displayed, "List of integers");

   Int_List.Add (2, Added);
   Ada_Check.Check ("the first fits", Added);
   Int_List.Add (5, Added);
   Ada_Check.Check ("the second fits", Added);
   Int_List.Add (7, Added);
   Ada_Check.Check ("the third fits", Added);

   --  Three slots, so the fourth cannot be added and must say so.
   Int_List.Add (9, Added);
   Ada_Check.Check ("the fourth does not fit", not Added);

   Ada_Check.Equal
     (Name     => "three integers, in order",
      Actual   => Displayed,
      Expected => "List of integers" & ASCII.LF & " 2" & ASCII.LF & " 5" & ASCII.LF & " 7");

   --  The instance writes into Numbers and Count, which belong to this procedure. That is what
   --  the `in out` formal objects mean, and it is visible from out here.
   Ada_Check.Equal ("the count was written through", Count, 3);
   Ada_Check.Equal ("and so was the array", Numbers (1), 2);
   Ada_Check.Equal ("all of it", Numbers (3), 7);

   --  Init forgets rather than erases, so the list is empty and the storage is untouched.
   Int_List.Init;
   Ada_Check.Equal ("init empties the list", Count, 0);
   Ada_Check.Equal ("after init, nothing is displayed", Displayed, "List of integers");
   Ada_Check.Equal ("but the array still holds what it held", Numbers (1), 2);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Generic_List;
