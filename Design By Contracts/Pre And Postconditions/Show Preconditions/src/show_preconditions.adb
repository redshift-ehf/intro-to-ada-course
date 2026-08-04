with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Assertions; use Ada.Assertions;

procedure Show_Preconditions is

   --  A precondition is the caller's obligation: what must be true on the way in.
   procedure DB_Entry (Name : String; Age : Natural)
     with Pre => Name'Length > 0
   is
   begin
      Put_Line (Name & " is" & Natural'Image (Age));
   end DB_Entry;

   type Int_8 is range -2 ** 7 .. 2 ** 7 - 1;

   --  And a postcondition is the implementer's: what will be true on the way out.
   --  `Square'Result` names the value being returned.
   function Square (A : Int_8) return Int_8 is (A * A)
     with
       Pre  => Integer (A) * Integer (A) <= Integer (Int_8'Last),
       Post => (if abs A in 0 | 1 then Square'Result = abs A else Square'Result > A);

   type Int_8_Array is array (Integer range <>) of Int_8;

   --  `A'Old` is the value a parameter had *before* the call, which is how a postcondition
   --  talks about a change rather than a state.
   procedure Square_All (A : in out Int_8_Array)
     with Post => (for all I in A'Range => A (I) = A'Old (I) * A'Old (I))
   is
   begin
      for V of A loop
         V := Square (V);
      end loop;
   end Square_All;

   V : Int_8_Array := (-2, -1, 0, 1, 10, 11);
begin
   DB_Entry ("John", 30);

   begin
      DB_Entry ("", 21);
      Put_Line ("the precondition did not fire -- was -gnata forgotten?");
   exception
      when Assertion_Error =>
         Put_Line ("empty name refused by the precondition, as it should be");
   end;

   Put_Line ("Square (11) =" & Int_8'Image (Square (11)));

   begin
      Put_Line ("Square (12) =" & Int_8'Image (Square (12)));
   exception
      --  144 does not fit in an Int_8. The precondition catches it *before* the overflow, and
      --  says why, rather than leaving a Constraint_Error to be worked out afterwards.
      when Assertion_Error =>
         Put_Line ("Square (12) refused: the answer would not fit");
   end;

   Square_All (V);
   for E of V loop
      Put ( Int_8'Image (E));
   end loop;
   New_Line;
end Show_Preconditions;
