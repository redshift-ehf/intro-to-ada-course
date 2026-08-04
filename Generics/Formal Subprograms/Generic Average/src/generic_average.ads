--  The average of an array of anything at all, given a way to weigh one element.
generic
   type T_Range is range <>;

   --  `is private` this time, not `is digits <>`. So the element may be a record, and the body
   --  gets no arithmetic on it whatsoever.
   type T_Element is private;

   type T_Array is array (T_Range range <>) of T_Element;

   --  Which is why this exists. The instantiator says what a T_Element is worth, and the
   --  arithmetic happens in Float where it is available.
   with function To_Float (E : T_Element) return Float;
function Generic_Average (A : T_Array) return Float;
