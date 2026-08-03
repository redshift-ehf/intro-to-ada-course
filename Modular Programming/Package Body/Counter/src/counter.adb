package body Counter is

   --  Declared in the body, not the spec, so nothing outside this file can see or touch it. This
   --  is the plainest kind of encapsulation Ada offers.
   Count : Integer := 0;

   procedure Bump is
   begin
      Count := Count + 1;
   end Bump;

   function Value return Integer is
   begin
      return Count;
   end Value;

end Counter;
