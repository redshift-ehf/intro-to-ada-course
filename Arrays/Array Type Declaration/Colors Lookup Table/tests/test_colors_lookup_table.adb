with Ada.Command_Line;
with Ada_Check;
with Colors_Lookup_Table;

procedure Test_Colors_Lookup_Table is
   use Colors_Lookup_Table;
begin
   Ada_Check.Suite ("Colors Lookup Table");

   --  One slot per colour, counted by the compiler rather than by hand.
   Ada_Check.Equal ("one entry per colour", HTML_Color_RGB'Length, 11);

   Ada_Check.Equal ("Salmon red",    To_RGB (Salmon).Red,      16#FA#);
   Ada_Check.Equal ("Salmon green",  To_RGB (Salmon).Green,    16#80#);
   Ada_Check.Equal ("Salmon blue",   To_RGB (Salmon).Blue,     16#72#);
   Ada_Check.Equal ("Firebrick red", To_RGB (Firebrick).Red,   16#B2#);
   Ada_Check.Equal ("Red",           To_RGB (Red).Red,         16#FF#);
   Ada_Check.Equal ("Darkred",       To_RGB (Darkred).Red,     16#8B#);
   Ada_Check.Equal ("Lime",          To_RGB (Lime).Green,      16#FF#);
   Ada_Check.Equal ("Forestgreen",   To_RGB (Forestgreen).Red, 16#22#);
   Ada_Check.Equal ("Green",         To_RGB (Green).Green,     16#80#);
   Ada_Check.Equal ("Darkgreen",     To_RGB (Darkgreen).Green, 16#64#);
   Ada_Check.Equal ("Blue",          To_RGB (Blue).Blue,       16#FF#);
   Ada_Check.Equal ("Mediumblue",    To_RGB (Mediumblue).Blue, 16#CD#);
   Ada_Check.Equal ("Darkblue",      To_RGB (Darkblue).Blue,   16#8B#);

   --  Reading the table directly must agree with going through the function, or the function is
   --  doing something other than a lookup.
   Ada_Check.Equal ("the table and the function agree",
                    To_RGB_Lookup_Table (Forestgreen).Green,
                    To_RGB (Forestgreen).Green);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Colors_Lookup_Table;
