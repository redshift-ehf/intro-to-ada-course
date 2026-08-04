--  The Records chapter's colours again, with the case statement replaced by an array.
package Colors_Lookup_Table is

   type HTML_Color is
     (Salmon, Firebrick, Red, Darkred, Lime, Forestgreen,
      Green, Darkgreen, Blue, Mediumblue, Darkblue);

   subtype Int_Color is Integer range 0 .. 255;

   type RGB is record
      Red   : Int_Color;
      Green : Int_Color;
      Blue  : Int_Color;
   end record;

   --  An array indexed by the enumeration itself. There are exactly as many slots as there are
   --  colours, and the compiler knows it.
   type HTML_Color_RGB is array (HTML_Color) of RGB;

   To_RGB_Lookup_Table : constant HTML_Color_RGB :=
     (Salmon      => (16#FA#, 16#80#, 16#72#),
      Firebrick   => (16#B2#, 16#22#, 16#22#),
      Red         => (16#FF#, 16#00#, 16#00#),
      Darkred     => (16#8B#, 16#00#, 16#00#),
      Lime        => (16#00#, 16#FF#, 16#00#),
      Forestgreen => (16#22#, 16#8B#, 16#22#),
      Green       => (16#00#, 16#80#, 16#00#),
      Darkgreen   => (16#00#, 16#64#, 16#00#),
      Blue        => (16#00#, 16#00#, 16#FF#),
      Mediumblue  => (16#00#, 16#00#, 16#CD#),
      Darkblue    => (16#00#, 16#00#, 16#8B#));

   function To_RGB (C : HTML_Color) return RGB;

end Colors_Lookup_Table;
