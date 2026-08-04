with Ada.Command_Line;
with Ada_Check;
with Constrained_Array;

procedure Test_Constrained_Array is
   use Constrained_Array;

   Counted : constant My_Array := Init;

   Sample : My_Array := (100, 90, 80, 10, 20, 30, 40, 60, 50, 70);
begin
   Ada_Check.Suite ("Constrained Array");

   Ada_Check.Equal ("Init counts from one",  Counted (1),  1);
   Ada_Check.Equal ("Init fills the middle", Counted (5),  5);
   Ada_Check.Equal ("Init reaches ten",      Counted (10), 10);

   Ada_Check.Equal ("First_Elem",  First_Elem (Sample), 100);
   Ada_Check.Equal ("Last_Elem",   Last_Elem (Sample),  70);
   Ada_Check.Equal ("Length",      Length (Sample),     10);

   Double (Sample);
   Ada_Check.Equal ("Double doubles the first",  Sample (1),  200);
   Ada_Check.Equal ("Double doubles the fourth", Sample (4),  20);
   Ada_Check.Equal ("Double doubles the last",   Sample (10), 140);

   --  Length reports the array's own length, so it must not change when the values do.
   Ada_Check.Equal ("Length after doubling", Length (Sample), 10);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Constrained_Array;
