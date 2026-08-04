with Ada.Command_Line;
with Ada_Check;
with Unconstrained_Array;

procedure Test_Unconstrained_Array is
   use Unconstrained_Array;

   Five : My_Array (1 .. 5);

   Values : My_Array := (1, 2, 5, 10, -10);
   Diffs  : constant My_Array := Diff_Prev_Elem (Values);

   Single : constant My_Array := Diff_Prev_Elem (My_Array'(1 => 42));
begin
   Ada_Check.Suite ("Unconstrained Array");

   Init (Five);
   Ada_Check.Equal ("Init counts down from the length", Five (1), 5);
   Ada_Check.Equal ("Init reaches one",                 Five (5), 1);

   declare
      Nine : constant My_Array := Init (9, 5);
   begin
      Ada_Check.Equal ("Init (9, 5) starts at nine", Nine (1), 9);
      Ada_Check.Equal ("Init (9, 5) ends at five",   Nine (5), 5);
      Ada_Check.Equal ("Init (9, 5) is five long",   Nine'Length, 5);
   end;

   --  Differences are taken before doubling, so this is the untouched Values.
   Ada_Check.Equal ("the first difference is zero", Diffs (1), 0);
   Ada_Check.Equal ("2 - 1",                        Diffs (2), 1);
   Ada_Check.Equal ("5 - 2",                        Diffs (3), 3);
   Ada_Check.Equal ("10 - 5",                       Diffs (4), 5);
   Ada_Check.Equal ("-10 - 10",                     Diffs (5), -20);

   --  One element has nothing before it, and must not read off the front of the array.
   Ada_Check.Equal ("a single element differs from nothing", Single (1), 0);

   Double (Values);
   Ada_Check.Equal ("Double doubles the first", Values (1), 2);
   Ada_Check.Equal ("Double doubles the last",  Values (5), -20);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Unconstrained_Array;
