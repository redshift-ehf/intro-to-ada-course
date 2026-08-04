with Ada.Command_Line;
with Ada_Check;
with Numerical_Exception;

procedure Test_Numerical_Exception is
   use Numerical_Exception;

   function Reported (ID : Test_ID) return String is
      procedure Call is
      begin
         Check_Exception (ID);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Reported;

   --  Whether anything escaped Check_Exception at all, which is half of what it is for.
   function Escapes (ID : Test_ID) return Boolean is
      procedure Call is
      begin
         Check_Exception (ID);
      end Call;

      function Run return Boolean is
         Ignored : constant String := Ada_Check.Output_Of (Call'Access);
         pragma Unreferenced (Ignored);
      begin
         return False;
      end Run;
   begin
      return Run;
   exception
      when others =>
         return True;
   end Escapes;
begin
   Ada_Check.Suite ("Numerical Exception");

   Ada_Check.Equal ("test 1 reports a Constraint_Error",
                    Reported (1), "Constraint_Error detected!");
   Ada_Check.Equal ("test 2 reports its own message",
                    Reported (2), "Custom_Exception raised!");

   --  Check_Exception handles rather than propagates. Nothing gets out.
   Ada_Check.Check ("nothing escapes from test 1", not Escapes (1));
   Ada_Check.Check ("nothing escapes from test 2", not Escapes (2));

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Numerical_Exception;
