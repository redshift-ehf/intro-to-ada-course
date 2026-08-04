package body String_10 is

   function To_String_10 (S : String) return Ten_Chars is
      Result : Ten_Chars := (others => ' ');

      --  However many characters there is room for, and no more.
      Count : constant Natural := Natural'Min (S'Length, Result'Length);
   begin
      --  S'First is not assumed to be 1. A String that arrived as a slice starts wherever its
      --  slice started, and this is what makes the exercise work for one of those too.
      Result (1 .. Count) := S (S'First .. S'First + Count - 1);
      return Result;
   end To_String_10;

end String_10;
