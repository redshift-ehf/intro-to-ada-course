--  HTML colour names, and the hexadecimal codes behind them.
package Colors is

   type HTML_Color is
     (Salmon, Firebrick, Red, Darkred, Lime, Forestgreen,
      Green, Darkgreen, Blue, Mediumblue, Darkblue);

   --  A separate type that happens to share three of its literals with HTML_Color. Ada allows
   --  that: an enumeration literal behaves as a function returning its type, and functions
   --  overload. Where the two could both apply, the context decides which is meant.
   type Basic_HTML_Color is (Red, Green, Blue);

   function To_Integer (C : HTML_Color) return Integer;

   function To_HTML_Color (C : Basic_HTML_Color) return HTML_Color;

end Colors;
