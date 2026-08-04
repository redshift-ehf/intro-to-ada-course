package body Uninitialized_Value is

   function Image (O : Option) return String is
   begin
      if O = Uninitialized then
         raise Uninitialized_Error with "Uninitialized value detected!";
      end if;

      return Option'Image (O);
   end Image;

end Uninitialized_Value;
