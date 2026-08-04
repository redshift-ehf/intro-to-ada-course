package body Private_Colors is

   --  Given, as in the Records chapter.
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

   function Red_Of (C : RGB) return Int_Color is
   begin
      return C.Red;
   end Red_Of;

   function Green_Of (C : RGB) return Int_Color is
   begin
      return C.Green;
   end Green_Of;

   function Blue_Of (C : RGB) return Int_Color is
   begin
      return C.Blue;
   end Blue_Of;

end Private_Colors;
