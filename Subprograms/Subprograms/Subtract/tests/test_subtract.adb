with Ada.Command_Line;
with Ada_Check;
with Subtract;

procedure Test_Subtract is
begin
   Ada_Check.Suite ("Subtract");

   Ada_Check.Equal ("10 - 1",    Subtract (10, 1),    9);
   Ada_Check.Equal ("10 - 100",  Subtract (10, 100),  -90);
   Ada_Check.Equal ("0 - 5",     Subtract (0, 5),     -5);
   --  A negative second operand, which a solution written as A + B would pass and a solution
   --  written as abs (A - B) would not.
   Ada_Check.Equal ("0 - (-5)",  Subtract (0, -5),    5);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Subtract;
