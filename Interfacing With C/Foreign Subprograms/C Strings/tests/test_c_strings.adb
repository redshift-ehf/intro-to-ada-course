with Ada.Command_Line;
with Ada_Check;
with C_Strings;

procedure Test_C_Strings is
   use C_Strings;
begin
   Ada_Check.Suite ("C Strings");

   Ada_Check.Equal ("length of a word",    Length ("hello"), 5);
   Ada_Check.Equal ("length of nothing",   Length (""),      0);
   Ada_Check.Equal ("spaces count",        Length ("a b c"), 5);

   --  C's strlen stops at the first NUL, which is exactly what makes it different from
   --  S'Length -- and worth a test rather than a footnote.
   Ada_Check.Equal ("a NUL ends a C string early",
                    Length ("abc" & ASCII.NUL & "def"), 3);

   Ada_Check.Equal ("equal strings compare zero", Compare ("abc", "abc"), 0);
   Ada_Check.Check ("earlier compares negative",  Compare ("abc", "abd") < 0);
   Ada_Check.Check ("later compares positive",    Compare ("abd", "abc") > 0);
   Ada_Check.Check ("shorter compares negative",  Compare ("ab", "abc") < 0);

   Ada_Check.Equal ("uppercased",            Upper ("hello"), "HELLO");
   Ada_Check.Equal ("already uppercase",     Upper ("HELLO"), "HELLO");
   Ada_Check.Equal ("mixed",                 Upper ("Hello, World!"), "HELLO, WORLD!");
   Ada_Check.Equal ("nothing to uppercase",  Upper (""), "");

   --  The result keeps the argument's bounds, which a slice makes visible.
   declare
      Text : constant String := "the quick brown fox";
   begin
      Ada_Check.Equal ("a slice keeps its own bounds",
                       Upper (Text (5 .. 9)), "QUICK");
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_C_Strings;
