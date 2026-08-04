with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

--  Joining an array of unbounded strings, with two things optional: trimming each piece, and a
--  space between the pieces.
package Concatenation is

   --  An array of Unbounded_String, which an array of String could not be -- String is
   --  indefinite, and Unbounded_String is not.
   type Unbounded_Strings is array (Positive range <>) of Unbounded_String;

   function Concat (USA            : Unbounded_Strings;
                    Trim_Str       : Boolean;
                    Add_Whitespace : Boolean) return Unbounded_String;

   function Concat (USA            : Unbounded_Strings;
                    Trim_Str       : Boolean;
                    Add_Whitespace : Boolean) return String;

end Concatenation;
