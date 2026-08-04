with Ada.Command_Line;
with Ada.Exceptions;
with Ada_Check;
with Uninitialized_Value;

procedure Test_Uninitialized_Value is
   use Uninitialized_Value;

   --  What escaped, as text, so a test can assert on it.
   --
   --  The call sits in an inner block's declarative part, and the handler is on the *enclosing*
   --  body. That is not decoration: an exception raised in a declarative part is not caught by
   --  that block's own handlers, so putting the handler on the same block as the declaration
   --  would let Uninitialized_Error straight past. Written the obvious way first, and this test
   --  failed exactly as the Handling An Exception lesson says it would.
   function Outcome (O : Option) return String is
   begin
      declare
         Ignored : constant String := Image (O);
         pragma Unreferenced (Ignored);
      begin
         return "no exception";
      end;
   exception
      when E : Uninitialized_Error =>
         return "Uninitialized_Error: " & Ada.Exceptions.Exception_Message (E);
      when others =>
         return "some other exception";
   end Outcome;
begin
   Ada_Check.Suite ("Uninitialized Value");

   Ada_Check.Equal ("Option_1", Image (Option_1), "OPTION_1");
   Ada_Check.Equal ("Option_2", Image (Option_2), "OPTION_2");
   Ada_Check.Equal ("Option_3", Image (Option_3), "OPTION_3");

   --  The whole point: the one value that means "not set yet" is not quietly printed.
   Ada_Check.Equal ("Uninitialized raises, with its message",
                    Outcome (Uninitialized),
                    "Uninitialized_Error: Uninitialized value detected!");

   Ada_Check.Equal ("and a real option does not raise", Outcome (Option_2), "no exception");

   --  Uninitialized is deliberately first, so it is what a Option variable defaults to when
   --  nobody says otherwise.
   Ada_Check.Equal ("Uninitialized comes first", Option'Image (Option'First), "UNINITIALIZED");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Uninitialized_Value;
