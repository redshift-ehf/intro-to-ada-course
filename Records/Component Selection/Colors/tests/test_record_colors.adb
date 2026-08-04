with Ada.Command_Line;
with Ada_Check;
with Record_Colors;

procedure Test_Record_Colors is
   use Record_Colors;
begin
   Ada_Check.Suite ("Colors");

   --  Each channel on its own, so a failure says which one is wrong rather than just that the
   --  whole colour is.
   Ada_Check.Equal ("Salmon red",   To_RGB (Salmon).Red,   16#FA#);
   Ada_Check.Equal ("Salmon green", To_RGB (Salmon).Green, 16#80#);
   Ada_Check.Equal ("Salmon blue",  To_RGB (Salmon).Blue,  16#72#);

   Ada_Check.Equal ("Firebrick red",   To_RGB (Firebrick).Red,   16#B2#);
   Ada_Check.Equal ("Firebrick green", To_RGB (Firebrick).Green, 16#22#);
   Ada_Check.Equal ("Firebrick blue",  To_RGB (Firebrick).Blue,  16#22#);

   Ada_Check.Equal ("Red is all red",       To_RGB (Red).Red,         16#FF#);
   Ada_Check.Equal ("Red has no green",     To_RGB (Red).Green,       16#00#);
   Ada_Check.Equal ("Darkred is dimmer",    To_RGB (Darkred).Red,     16#8B#);
   Ada_Check.Equal ("Lime is all green",    To_RGB (Lime).Green,      16#FF#);
   Ada_Check.Equal ("Forestgreen red",      To_RGB (Forestgreen).Red, 16#22#);
   Ada_Check.Equal ("Green is half",        To_RGB (Green).Green,     16#80#);
   Ada_Check.Equal ("Darkgreen is less",    To_RGB (Darkgreen).Green, 16#64#);
   Ada_Check.Equal ("Blue is all blue",     To_RGB (Blue).Blue,       16#FF#);
   Ada_Check.Equal ("Mediumblue is dimmer", To_RGB (Mediumblue).Blue, 16#CD#);
   Ada_Check.Equal ("Darkblue is dimmest",  To_RGB (Darkblue).Blue,   16#8B#);

   Ada_Check.Equal
     ("Salmon reads back as text",
      Image (To_RGB (Salmon)),
      "(Red => 16#FA#, Green => 16#80#, Blue => 16#72#)");
   Ada_Check.Equal
     ("Red reads back as text",
      Image (To_RGB (Red)),
      "(Red => 16#FF#, Green => 16#00#, Blue => 16#00#)");
   Ada_Check.Equal
     ("Darkblue reads back as text",
      Image (To_RGB (Darkblue)),
      "(Red => 16#00#, Green => 16#00#, Blue => 16#8B#)");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Record_Colors;
