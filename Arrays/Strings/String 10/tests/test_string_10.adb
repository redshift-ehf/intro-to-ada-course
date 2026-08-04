with Ada.Command_Line;
with Ada_Check;
with String_10;

procedure Test_String_10 is
   use String_10;

   Long_Text : constant String := "And this is a long string";
begin
   Ada_Check.Suite ("String_10");

   Ada_Check.Equal ("a long string is cut to ten",
                    To_String_10 (Long_Text), "And this i");
   Ada_Check.Equal ("a short string is padded",
                    To_String_10 ("Hey!"), "Hey!      ");
   Ada_Check.Equal ("exactly ten is left alone",
                    To_String_10 ("0123456789"), "0123456789");
   Ada_Check.Equal ("eleven loses its last character",
                    To_String_10 ("0123456789X"), "0123456789");
   Ada_Check.Equal ("an empty string is all spaces",
                    To_String_10 (""), "          ");

   --  The result is always ten characters, whatever went in.
   Ada_Check.Equal ("the answer is always ten long",
                    To_String_10 ("Hey!")'Length, 10);

   --  A slice does not start at index 1, and must still work. Long_Text (10 .. 25) is
   --  "is a long string", so the first ten characters of it are "is a long ".
   Ada_Check.Equal ("a slice is handled by its own bounds",
                    To_String_10 (Long_Text (10 .. 25)), "is a long ");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_String_10;
