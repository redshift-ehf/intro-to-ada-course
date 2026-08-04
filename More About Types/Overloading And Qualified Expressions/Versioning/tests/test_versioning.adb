with Ada.Command_Line;
with Ada_Check;
with Versioning;

procedure Test_Versioning is
   use Versioning;

   V : constant Version := (Major => 1, Minor => 3, Maintenance => 23);

   --  Which Convert runs is settled by what each of these is declared to be.
   As_Text   : constant String := Convert (V);
   As_Number : constant Float  := Convert (V);
begin
   Ada_Check.Suite ("Versioning");

   Ada_Check.Equal ("1.3.23 as text", As_Text, "1.3.23");
   Ada_Check.Equal ("1.3.23 as a number", As_Number, 1.3);

   --  In an expression there is no declaration to read the type from, so the qualified
   --  expression does that job instead -- which is this lesson's whole subject.
   Ada_Check.Equal ("qualified, as text", String'(Convert (V)), "1.3.23");
   Ada_Check.Equal ("qualified, as a number", Float'(Convert (V)), 1.3);

   Ada_Check.Equal ("no leading spaces anywhere",
                    String'(Convert (Version'(10, 0, 5))), "10.0.5");
   Ada_Check.Equal ("a zero major version",
                    String'(Convert (Version'(0, 9, 1))), "0.9.1");
   Ada_Check.Equal ("the number ignores maintenance",
                    Float'(Convert (Version'(2, 5, 99))), 2.5);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Versioning;
