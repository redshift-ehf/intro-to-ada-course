with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

package body Numerical_Exception is

   Numbers : constant array (1 .. 3) of Integer := (1, 2, 3);

   procedure Num_Exception_Test (ID : Test_ID) is
      Result : Integer;
   begin
      case ID is
         when 1 =>
            --  Index 4 of a three-element array. The index comes from ID so the check happens
            --  while the program runs rather than being settled by the compiler.
            Result := Numbers (Integer (ID) + 3);
            Put_Line (Integer'Image (Result));

         when 2 =>
            raise Custom_Exception with "Custom_Exception raised!";
      end case;
   end Num_Exception_Test;

   procedure Check_Exception (ID : Test_ID) is
   begin
      Num_Exception_Test (ID);
   exception
      when Constraint_Error =>
         Put_Line ("Constraint_Error detected!");
      when E : others =>
         --  Anything else: say what it said. Binding the occurrence with `E :` is what makes
         --  the message reachable.
         Put_Line (Exception_Message (E));
   end Check_Exception;

end Numerical_Exception;
