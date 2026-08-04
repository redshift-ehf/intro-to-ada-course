--  The average of an array of any floating-point type.
generic
   type T_Range is range <>;

   --  `is digits <>` promises a floating-point type, which is what buys the body its
   --  arithmetic -- +, / and the conversion from an integer length.
   type T_Element is digits <>;

   type T_Array is array (T_Range range <>) of T_Element;
function Float_Average (A : T_Array) return T_Element;
