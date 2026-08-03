with Ada.Command_Line;
with Ada_Check;
with Integers;

procedure Test_Integers is
   use Integers;
begin
   Ada_Check.Suite ("Integers");

   Ada_Check.Equal ("U_100 42 becomes I_100 42",
                    Integer (To_I_100 (U_100'(42))), 42);
   Ada_Check.Equal ("I_100 42 becomes U_100 42",
                    Integer (To_U_100 (I_100'(42))), 42);
   Ada_Check.Equal ("D_50 30 becomes I_100 30",
                    Integer (To_I_100 (D_50'(30))), 30);

   Ada_Check.Equal ("To_D_50 lifts 0 to 10",     Integer (To_D_50 (I_100'(0))),   10);
   Ada_Check.Equal ("To_D_50 lifts 9 to 10",     Integer (To_D_50 (I_100'(9))),   10);
   Ada_Check.Equal ("To_D_50 leaves 10 alone",   Integer (To_D_50 (I_100'(10))),  10);
   Ada_Check.Equal ("To_D_50 leaves 30 alone",   Integer (To_D_50 (I_100'(30))),  30);
   Ada_Check.Equal ("To_D_50 leaves 50 alone",   Integer (To_D_50 (I_100'(50))),  50);
   Ada_Check.Equal ("To_D_50 drops 51 to 50",    Integer (To_D_50 (I_100'(51))),  50);
   Ada_Check.Equal ("To_D_50 drops 100 to 50",   Integer (To_D_50 (I_100'(100))), 50);

   Ada_Check.Equal ("To_S_50 lifts 0 to 10",     Integer (To_S_50 (I_100'(0))),   10);
   Ada_Check.Equal ("To_S_50 lifts 9 to 10",     Integer (To_S_50 (I_100'(9))),   10);
   Ada_Check.Equal ("To_S_50 leaves 10 alone",   Integer (To_S_50 (I_100'(10))),  10);
   Ada_Check.Equal ("To_S_50 leaves 30 alone",   Integer (To_S_50 (I_100'(30))),  30);
   Ada_Check.Equal ("To_S_50 leaves 50 alone",   Integer (To_S_50 (I_100'(50))),  50);
   Ada_Check.Equal ("To_S_50 drops 51 to 50",    Integer (To_S_50 (I_100'(51))),  50);
   Ada_Check.Equal ("To_S_50 drops 100 to 50",   Integer (To_S_50 (I_100'(100))), 50);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Integers;
