with Interfaces.C; use Interfaces.C;

package body C_Strings is

   --  Three functions from the C library. No C source of ours, and no linker flags: libc is
   --  already there.
   function Strlen (S : char_array) return size_t
     with Import, Convention => C, External_Name => "strlen";

   function Strcmp (Left, Right : char_array) return int
     with Import, Convention => C, External_Name => "strcmp";

   function Toupper (C : int) return int
     with Import, Convention => C, External_Name => "toupper";

   function Length (S : String) return Natural is
      --  To_C appends the NUL that every C string function is looking for. Handing over an Ada
      --  String's own storage instead would leave strlen reading past the end of it.
      Buffer : constant char_array := To_C (S);
   begin
      return Natural (Strlen (Buffer));
   end Length;

   function Compare (Left, Right : String) return Integer is
      L : constant char_array := To_C (Left);
      R : constant char_array := To_C (Right);
   begin
      return Integer (Strcmp (L, R));
   end Compare;

   function Upper (S : String) return String is
      Result : String (S'Range);
   begin
      for I in S'Range loop
         Result (I) := Character'Val (Integer (Toupper (int (Character'Pos (S (I))))));
      end loop;
      return Result;
   end Upper;

end C_Strings;
