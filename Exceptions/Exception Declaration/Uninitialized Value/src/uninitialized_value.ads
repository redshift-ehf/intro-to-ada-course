--  An enumeration with a value meaning "nobody has set this yet", and an exception for anyone
--  who tries to use it.
package Uninitialized_Value is

   type Option is (Uninitialized, Option_1, Option_2, Option_3);

   --  Named Uninitialized_Error rather than Uninitialized_Value, because that is this package's
   --  own name and a declaration inside it would hide it.
   Uninitialized_Error : exception;

   --  Raises Uninitialized_Error for Uninitialized; otherwise the option's name.
   function Image (O : Option) return String;

end Uninitialized_Value;
