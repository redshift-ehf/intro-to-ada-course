with Ada.Command_Line;
with Ada_Check;
with Colors;

procedure Test_Colors is
begin
   Ada_Check.Suite ("Colors");

   --  `Colors.Red` names two different literals. It is never written out here, because it never
   --  has to be: To_Integer takes an HTML_Color and To_HTML_Color takes a Basic_HTML_Color, so
   --  each call has exactly one reading that type-checks.
   Ada_Check.Equal ("Salmon",      Colors.To_Integer (Colors.Salmon),      16#FA8072#);
   Ada_Check.Equal ("Firebrick",   Colors.To_Integer (Colors.Firebrick),   16#B22222#);
   Ada_Check.Equal ("Red",         Colors.To_Integer (Colors.Red),         16#FF0000#);
   Ada_Check.Equal ("Darkred",     Colors.To_Integer (Colors.Darkred),     16#8B0000#);
   Ada_Check.Equal ("Lime",        Colors.To_Integer (Colors.Lime),        16#00FF00#);
   Ada_Check.Equal ("Forestgreen", Colors.To_Integer (Colors.Forestgreen), 16#228B22#);
   Ada_Check.Equal ("Green",       Colors.To_Integer (Colors.Green),       16#008000#);
   Ada_Check.Equal ("Darkgreen",   Colors.To_Integer (Colors.Darkgreen),   16#006400#);
   Ada_Check.Equal ("Blue",        Colors.To_Integer (Colors.Blue),        16#0000FF#);
   Ada_Check.Equal ("Mediumblue",  Colors.To_Integer (Colors.Mediumblue),  16#0000CD#);
   Ada_Check.Equal ("Darkblue",    Colors.To_Integer (Colors.Darkblue),    16#00008B#);

   Ada_Check.Equal
     ("basic Red becomes HTML Red",
      Colors.HTML_Color'Image (Colors.To_HTML_Color (Colors.Red)),   "RED");
   Ada_Check.Equal
     ("basic Green becomes HTML Green",
      Colors.HTML_Color'Image (Colors.To_HTML_Color (Colors.Green)), "GREEN");
   Ada_Check.Equal
     ("basic Blue becomes HTML Blue",
      Colors.HTML_Color'Image (Colors.To_HTML_Color (Colors.Blue)),  "BLUE");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Colors;
