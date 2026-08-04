--  HTML colours again, this time as three components rather than one number.
--
--  The unit is Record_Colors, not Colors: the Strongly Typed Language chapter already has a
--  Colors, the whole course is a single GNAT project, and two library units cannot share a name.
--  The chapter qualifier is how this course settles that -- see check_unit_names in
--  scripts/check_course.py.
package Record_Colors is

   type HTML_Color is
     (Salmon, Firebrick, Red, Darkred, Lime, Forestgreen,
      Green, Darkgreen, Blue, Mediumblue, Darkblue);

   --  One byte per channel, which is what an HTML colour code is.
   subtype Int_Color is Integer range 0 .. 255;

   type RGB is record
      Red   : Int_Color;
      Green : Int_Color;
      Blue  : Int_Color;
   end record;

   function To_RGB (C : HTML_Color) return RGB;

   function Image (C : RGB) return String;

end Record_Colors;
