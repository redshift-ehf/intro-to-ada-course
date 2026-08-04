package body Record_Colors is

   --  Given: two hexadecimal digits, always, so that a column of these lines up.
   function Hex (V : Int_Color) return String is
      Digit : constant String := "0123456789ABCDEF";
   begin
      return "16#" & Digit (V / 16 + 1) & Digit (V mod 16 + 1) & "#";
   end Hex;

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

   function Image (C : RGB) return String is
   begin
      return "(Red => " & Hex (C.Red)
             & ", Green => " & Hex (C.Green)
             & ", Blue => " & Hex (C.Blue) & ")";
   end Image;

end Record_Colors;
