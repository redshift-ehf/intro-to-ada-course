--  Ada strings, handled by C's string functions.
--
--  An original exercise; AdaCore's Laboratories has no Interfacing With C chapter. There is no
--  C source here either -- everything imported is already in the C library every program links.
package C_Strings is

   --  The length C would report: up to the first NUL, which is not the same as S'Length.
   function Length (S : String) return Natural;

   --  Negative, zero or positive, as C's strcmp reports it.
   function Compare (Left, Right : String) return Integer;

   --  Uppercased a character at a time by C's toupper.
   function Upper (S : String) return String;

end C_Strings;
