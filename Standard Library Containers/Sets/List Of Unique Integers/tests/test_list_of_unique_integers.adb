with Ada.Command_Line;
with Ada.Containers;
with Ada_Check;
with List_Of_Unique_Integers;

procedure Test_List_Of_Unique_Integers is
   use List_Of_Unique_Integers;
   use type Ada.Containers.Count_Type;

   --  Both Get_Unique functions are exercised through these two, and which one each reaches is
   --  decided by the return type alone.
   function As_Set (A : Int_Array) return String is
      S    : constant Int_Set := Get_Unique (A);
      Text : String (1 .. 200);
      Last : Natural := 0;
   begin
      for E of S loop
         declare
            Image : constant String := Integer'Image (E);
         begin
            Text (Last + 1 .. Last + Image'Length) := Image;
            Last := Last + Image'Length;
         end;
      end loop;
      return Text (1 .. Last);
   end As_Set;

   function As_Array (A : Int_Array) return String is
      AU   : constant Int_Array := Get_Unique (A);
      Text : String (1 .. 200);
      Last : Natural := 0;
   begin
      for E of AU loop
         declare
            Image : constant String := Integer'Image (E);
         begin
            Text (Last + 1 .. Last + Image'Length) := Image;
            Last := Last + Image'Length;
         end;
      end loop;
      return Text (1 .. Last);
   end As_Array;

   Short : constant Int_Array := (5, 6, 3, 3, 5, 2);
   Long  : constant Int_Array := (5, 6, 3, 3, 5, 2, 3, 5, 5, 8, 6, 2, 3, 2);
begin
   Ada_Check.Suite ("List of unique integers");

   --  The lab's own four cases.
   Ada_Check.Equal ("set: duplicates out, order in", As_Set (Short), " 2 3 5 6");
   Ada_Check.Equal ("set: more duplicates", As_Set (Long), " 2 3 5 6 8");
   Ada_Check.Equal ("array: duplicates out, order in", As_Array (Short), " 2 3 5 6");
   Ada_Check.Equal ("array: more duplicates", As_Array (Long), " 2 3 5 6 8");

   --  The example from the exercise text.
   Ada_Check.Equal ("(7, 7, 1) becomes (1, 7)", As_Array ((7, 7, 1)), " 1 7");

   --  Nothing in, nothing out. Length has to be right or the returned array is malformed.
   declare
      Nothing : constant Int_Array (1 .. 0) := (1 .. 0 => 0);
      Empty   : constant Int_Array := Get_Unique (Nothing);
   begin
      Ada_Check.Equal ("an empty array gives an empty array", Empty'Length, 0);
      Ada_Check.Equal ("and an empty set", As_Set (Nothing), "");
   end;

   --  One element, repeated: the set collapses it to one and the array has one slot.
   declare
      Same : constant Int_Array := (4, 4, 4, 4, 4);
      One  : constant Int_Array := Get_Unique (Same);
   begin
      Ada_Check.Equal ("five of the same is one", One'Length, 1);
      Ada_Check.Equal ("and it is the right one", One (One'First), 4);
   end;

   --  The returned array must be indexed from 1, whatever the input was indexed from -- Int_Array
   --  is unconstrained, so the bounds are the function's to choose and a test can tell.
   declare
      Offset : constant Int_Array (10 .. 13) := (9, 7, 9, 8);
      Got    : constant Int_Array := Get_Unique (Offset);
   begin
      Ada_Check.Equal ("the result starts at 1", Got'First, 1);
      Ada_Check.Equal ("and ends at its length", Got'Last, 3);
      Ada_Check.Equal ("sorted", As_Array (Offset), " 7 8 9");
   end;

   --  Negatives sort where they belong, not by absolute value.
   Ada_Check.Equal ("negatives", As_Array ((3, -1, 3, -7, 0)), "-7-1 0 3");

   --  The set version really is a set.
   declare
      S : constant Int_Set := Get_Unique (Long);
   begin
      Ada_Check.Check ("five distinct values", S.Length = 5);
      Ada_Check.Check ("and it contains 8", S.Contains (8));
      Ada_Check.Check ("but not 9", not S.Contains (9));
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_List_Of_Unique_Integers;
