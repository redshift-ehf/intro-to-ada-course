--  Display any array of anything, given a way to turn one element into text.
generic
   --  The index type, the element type, and the array built from them. All three are needed:
   --  knowing the element type does not tell the compiler how the array is indexed.
   type T_Range is range <>;
   type T_Element is private;
   type T_Array is array (T_Range range <>) of T_Element;

   --  `is private` promises only assignment and equality, so there is no way to print a
   --  T_Element from inside. The instantiator supplies one.
   with function Image (E : T_Element) return String;
procedure Display_Array (Header : String; A : T_Array);
