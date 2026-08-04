with Ada.Command_Line;
with Ada.Assertions;
with Ada_Check;
with Primary_Color;

procedure Test_Primary_Color is
   use Primary_Color;

   --  Passing a colour that is not one of the three primaries. Written through a variable so
   --  the check happens at run time rather than being refused by the compiler.
   function Channel_Of (C : HTML_Color; S : HTML_Color) return String is
      Selector : HTML_RGB_Color;
   begin
      Selector := S;
      return Int_Color'Image (To_Int_Color (C, Selector));
   exception
      when Ada.Assertions.Assertion_Error => return "refused";
   end Channel_Of;
begin
   Ada_Check.Suite ("Primary Color");

   Ada_Check.Equal ("Salmon's red",   To_Int_Color (Salmon, Red),   16#FA#);
   Ada_Check.Equal ("Salmon's green", To_Int_Color (Salmon, Green), 16#80#);
   Ada_Check.Equal ("Salmon's blue",  To_Int_Color (Salmon, Blue),  16#72#);

   Ada_Check.Equal ("Firebrick's red",   To_Int_Color (Firebrick, Red),   16#B2#);
   Ada_Check.Equal ("Darkblue's blue",   To_Int_Color (Darkblue, Blue),   16#8B#);
   Ada_Check.Equal ("Forestgreen's green", To_Int_Color (Forestgreen, Green), 16#8B#);
   Ada_Check.Equal ("Lime has no red",   To_Int_Color (Lime, Red),        16#00#);

   --  The three primaries are selectors as well as colours.
   Ada_Check.Equal ("Red's own red", To_Int_Color (Red, Red), 16#FF#);

   --  Anything else is not a selector, and the predicate says so.
   Ada_Check.Equal ("Salmon is not a channel",    Channel_Of (Red, Salmon),    "refused");
   Ada_Check.Equal ("Darkgreen is not a channel", Channel_Of (Red, Darkgreen), "refused");

   --  And one that is, through the same path, to show the refusal is the predicate and not the
   --  path itself.
   Ada_Check.Equal ("Green is a channel", Channel_Of (Lime, Green), " 255");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Primary_Color;
