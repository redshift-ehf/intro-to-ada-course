with Ada.Command_Line;
with Ada_Check;
with Re_Raising_Exceptions;

procedure Test_Re_Raising_Exceptions is
   use Re_Raising_Exceptions;

   --  What was printed before the exception left. The inner block swallows it so that only the
   --  printing is measured here.
   function Reported (ID : Test_ID) return String is
      procedure Call is
      begin
         begin
            Check_Exception (ID);
         exception
            when others => null;
         end;
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Reported;

   --  And which exception came out. Output_Of re-raises after restoring standard output, so the
   --  occurrence reaches the handler below -- but from the declarative part of Run, which is
   --  why the handler is on the enclosing body rather than on Run itself.
   function Escaped (ID : Test_ID) return String is
      procedure Call is
      begin
         Check_Exception (ID);
      end Call;

      function Run return String is
         Ignored : constant String := Ada_Check.Output_Of (Call'Access);
         pragma Unreferenced (Ignored);
      begin
         return "nothing escaped";
      end Run;
   begin
      return Run;
   exception
      when Constraint_Error  => return "Constraint_Error";
      when Another_Exception => return "Another_Exception";
      when Custom_Exception  => return "Custom_Exception";
      when others            => return "something else";
   end Escaped;
begin
   Ada_Check.Suite ("Re-raising Exceptions");

   Ada_Check.Equal ("test 1 reports first", Reported (1), "Constraint_Error detected!");
   Ada_Check.Equal ("test 2 reports first", Reported (2), "Custom_Exception raised!");

   --  A bare `raise` sends the same exception onward, so what escapes is still a
   --  Constraint_Error.
   Ada_Check.Equal ("test 1 re-raises what it caught", Escaped (1), "Constraint_Error");

   --  The other branch raises something of its own instead, so Custom_Exception does not
   --  escape -- Another_Exception does.
   Ada_Check.Equal ("test 2 raises its own instead", Escaped (2), "Another_Exception");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Re_Raising_Exceptions;
