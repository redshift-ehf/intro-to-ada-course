with Ada.Strings; use Ada.Strings;

package body Concatenation is

   function Concat (USA            : Unbounded_Strings;
                    Trim_Str       : Boolean;
                    Add_Whitespace : Boolean) return Unbounded_String
   is
      Result : Unbounded_String := Null_Unbounded_String;
   begin
      for I in USA'Range loop
         --  Trim is Ada.Strings.Unbounded's, taking and returning an Unbounded_String. Both
         --  means both ends.
         Result := Result & (if Trim_Str then Trim (USA (I), Both) else USA (I));

         --  Between the pieces, not after the last one.
         if Add_Whitespace and then I < USA'Last then
            Result := Result & " ";
         end if;
      end loop;

      return Result;
   end Concat;

   function Concat (USA            : Unbounded_Strings;
                    Trim_Str       : Boolean;
                    Add_Whitespace : Boolean) return String
   is
      --  The other Concat, chosen by what Joined is declared to be.
      Joined : constant Unbounded_String := Concat (USA, Trim_Str, Add_Whitespace);
   begin
      return To_String (Joined);
   end Concat;

end Concatenation;
