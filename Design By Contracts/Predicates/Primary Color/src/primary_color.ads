--  Picking one channel out of an HTML colour, where "one channel" is itself a type.
package Primary_Color is

   type HTML_Color is
     (Salmon, Firebrick, Red, Darkred, Lime, Forestgreen,
      Green, Darkgreen, Blue, Mediumblue, Darkblue);

   subtype Int_Color is Integer range 0 .. 255;

   --  A subtype of exactly three values, which are not next to each other in the enumeration
   --  and so cannot be a range. This is what static predicates are for.
   subtype HTML_RGB_Color is HTML_Color
     with Static_Predicate => HTML_RGB_Color in Red | Green | Blue;

   --  The S channel of colour C. S can only be one of the three, checked at the call.
   function To_Int_Color (C : HTML_Color; S : HTML_RGB_Color) return Int_Color;

end Primary_Color;
