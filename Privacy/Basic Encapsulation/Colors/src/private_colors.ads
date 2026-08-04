--  The Records chapter's colours, with RGB made private.
--
--  The unit is Private_Colors: `Colors` belongs to Strongly Typed Language and `Record_Colors`
--  to Records, and one GNAT project is one namespace. Third use, third qualifier.
package Private_Colors is

   type HTML_Color is
     (Salmon, Firebrick, Red, Darkred, Lime, Forestgreen,
      Green, Darkgreen, Blue, Mediumblue, Darkblue);

   subtype Int_Color is Integer range 0 .. 255;

   --  Private. Callers get the name and nothing else -- which is why the three channels below
   --  need functions to reach them at all.
   type RGB is private;

   function To_RGB (C : HTML_Color) return RGB;

   function Image (C : RGB) return String;

   function Red_Of (C : RGB) return Int_Color;

   function Green_Of (C : RGB) return Int_Color;

   function Blue_Of (C : RGB) return Int_Color;

private

   type RGB is record
      Red   : Int_Color;
      Green : Int_Color;
      Blue  : Int_Color;
   end record;

end Private_Colors;
