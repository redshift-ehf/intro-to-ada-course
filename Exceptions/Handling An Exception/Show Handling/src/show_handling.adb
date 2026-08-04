with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

procedure Show_Handling is

   function Dangerous return Integer is
   begin
      raise Constraint_Error with "from Dangerous";
      return 42;
   end Dangerous;

   procedure Careless is
   begin
      --  The handler below belongs to *this* block, and the declaration that raises is in the
      --  inner block's declarative part -- which the inner block's own handler cannot reach.
      declare
         A : constant Integer := Dangerous;
      begin
         Put_Line (Integer'Image (A));
      exception
         when Constraint_Error =>
            Put_Line ("the inner handler never runs");
      end;
   exception
      when E : Constraint_Error =>
         Put_Line ("caught out here instead: " & Exception_Message (E));
   end Careless;

begin
   --  A handler can be attached to any block, including a subprogram body.
   begin
      raise Constraint_Error with "in a plain block";
   exception
      when E : Constraint_Error =>
         Put_Line ("handled: " & Exception_Message (E));
   end;

   --  Handlers are tried in order, and `others` catches whatever is left.
   begin
      raise Program_Error with "not Constraint_Error";
   exception
      when Constraint_Error =>
         Put_Line ("not this one");
      when E : others =>
         Put_Line ("caught by others: " & Exception_Name (E));
   end;

   Careless;
end Show_Handling;
