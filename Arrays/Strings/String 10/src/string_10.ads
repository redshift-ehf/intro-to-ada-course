--  Fitting any String into exactly ten characters.
package String_10 is

   --  A constrained String subtype: still a String, with its bounds pinned down.
   subtype Ten_Chars is String (1 .. 10);

   --  Longer input is cut off; shorter input is padded on the right with spaces.
   function To_String_10 (S : String) return Ten_Chars;

end String_10;
