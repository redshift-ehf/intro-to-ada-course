with Ada.Command_Line;
with Ada_Check;
with Is_Equal;

procedure Test_Is_Equal is
begin
   Ada_Check.Suite ("Is Equal");

   Ada_Check.Check ("0 equals 0",        Is_Equal (0, 0));
   Ada_Check.Check ("-1 equals -1",      Is_Equal (-1, -1));
   --  Both directions, because a solution returning True unconditionally passes the first two.
   Ada_Check.Check ("0 differs from -1", not Is_Equal (0, -1));
   Ada_Check.Check ("100 differs from 1", not Is_Equal (100, 1));

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Is_Equal;
