package body Primary_Color is

   type RGB is record
      Red   : Int_Color;
      Green : Int_Color;
      Blue  : Int_Color;
   end record;

   function To_RGB (C : HTML_Color) return RGB is
   begin
      case C is
         when Salmon      => return (16#FA#, 16#80#, 16#72#);
         when Firebrick   => return (16#B2#, 16#22#, 16#22#);
         when Red         => return (16#FF#, 16#00#, 16#00#);
         when Darkred     => return (16#8B#, 16#00#, 16#00#);
         when Lime        => return (16#00#, 16#FF#, 16#00#);
         when Forestgreen => return (16#22#, 16#8B#, 16#22#);
         when Green       => return (16#00#, 16#80#, 16#00#);
         when Darkgreen   => return (16#00#, 16#64#, 16#00#);
         when Blue        => return (16#00#, 16#00#, 16#FF#);
         when Mediumblue  => return (16#00#, 16#00#, 16#CD#);
         when Darkblue    => return (16#00#, 16#00#, 16#8B#);
      end case;
   end To_RGB;

   function To_Int_Color (C : HTML_Color; S : HTML_RGB_Color) return Int_Color is
      Channels : constant RGB := To_RGB (C);
   begin
      --  Written as if/elsif rather than a case. A `case` over S would be exhaustive with just
      --  three alternatives -- the predicate guarantees there are no others -- which is neater
      --  and would stop compiling the moment the predicate were wrong, so the exercise could
      --  not tell you what a missing predicate costs.
      if S = Red then
         return Channels.Red;
      elsif S = Green then
         return Channels.Green;
      else
         return Channels.Blue;
      end if;
   end To_Int_Color;

end Primary_Color;
