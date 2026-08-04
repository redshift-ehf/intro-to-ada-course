with Ada.Command_Line;
with Ada_Check;
with Private_Colors;

procedure Test_Private_Colors is
   use Private_Colors;

   Salmon_RGB : constant RGB := To_RGB (Salmon);
begin
   Ada_Check.Suite ("Colors, private");

   --  In the Records chapter this was To_RGB (Salmon).Red. It cannot be, now: RGB is private and
   --  has no components anybody out here can name.
   Ada_Check.Equal ("Salmon red",   Red_Of (Salmon_RGB),   16#FA#);
   Ada_Check.Equal ("Salmon green", Green_Of (Salmon_RGB), 16#80#);
   Ada_Check.Equal ("Salmon blue",  Blue_Of (Salmon_RGB),  16#72#);

   Ada_Check.Equal ("Firebrick red",   Red_Of (To_RGB (Firebrick)),   16#B2#);
   Ada_Check.Equal ("Red is all red",  Red_Of (To_RGB (Red)),         16#FF#);
   Ada_Check.Equal ("Darkred",         Red_Of (To_RGB (Darkred)),     16#8B#);
   Ada_Check.Equal ("Lime",            Green_Of (To_RGB (Lime)),      16#FF#);
   Ada_Check.Equal ("Forestgreen",     Red_Of (To_RGB (Forestgreen)), 16#22#);
   Ada_Check.Equal ("Green",           Green_Of (To_RGB (Green)),     16#80#);
   Ada_Check.Equal ("Darkgreen",       Green_Of (To_RGB (Darkgreen)), 16#64#);
   Ada_Check.Equal ("Blue",            Blue_Of (To_RGB (Blue)),       16#FF#);
   Ada_Check.Equal ("Mediumblue",      Blue_Of (To_RGB (Mediumblue)), 16#CD#);
   Ada_Check.Equal ("Darkblue",        Blue_Of (To_RGB (Darkblue)),   16#8B#);

   Ada_Check.Equal
     ("Salmon reads back as text",
      Image (Salmon_RGB),
      "(Red => 16#FA#, Green => 16#80#, Blue => 16#72#)");

   --  A private type keeps assignment and equality. Both still work here, and that is the
   --  difference between `private` and `limited private`.
   declare
      Copy : constant RGB := Salmon_RGB;
   begin
      Ada_Check.Check ("a private value can be copied", Copy = Salmon_RGB);
      Ada_Check.Check ("and compared against another",  Copy /= To_RGB (Red));
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Private_Colors;
