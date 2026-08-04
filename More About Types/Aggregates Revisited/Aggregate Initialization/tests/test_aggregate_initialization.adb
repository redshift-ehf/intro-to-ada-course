with Ada.Command_Line;
with Ada_Check;
with Aggregate_Initialization;

procedure Test_Aggregate_Initialization is
   use Aggregate_Initialization;

   Untouched : Rec;
   R         : Rec;
   Partly    : Int_Arr;
   All_Five  : Int_Arr;
begin
   Ada_Check.Suite ("Aggregate Initialization");

   --  What the defaults alone give, so the next block can be read as a difference from it.
   Ada_Check.Equal ("default W", Untouched.W, 10);
   Ada_Check.Equal ("default X", Untouched.X, 11);
   Ada_Check.Equal ("default Y", Untouched.Y, 12);
   Ada_Check.Equal ("default Z", Untouched.Z, 13);

   Init (R);
   Ada_Check.Equal ("Init leaves W at its default", R.W, 10);
   Ada_Check.Equal ("Init sets X",                  R.X, 100);
   Ada_Check.Equal ("Init sets Y",                  R.Y, 200);
   Ada_Check.Equal ("Init leaves Z at its default", R.Z, 13);

   Init_Some (Partly);
   Ada_Check.Equal ("Init_Some, first",     Partly (1),  99);
   Ada_Check.Equal ("Init_Some, fifth",     Partly (5),  99);
   Ada_Check.Equal ("Init_Some, sixth",     Partly (6),  100);
   Ada_Check.Equal ("Init_Some, twentieth", Partly (20), 100);

   Init (All_Five);
   Ada_Check.Equal ("Init fills the first",  All_Five (1),  5);
   Ada_Check.Equal ("Init fills the middle", All_Five (10), 5);
   Ada_Check.Equal ("Init fills the last",   All_Five (20), 5);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Aggregate_Initialization;
