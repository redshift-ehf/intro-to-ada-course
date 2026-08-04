with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

package body Re_Raising_Exceptions is

   Numbers : constant array (1 .. 3) of Integer := (1, 2, 3);

   procedure Num_Exception_Test (ID : Test_ID) is
      Result : Integer;
   begin
      case ID is
         when 1 =>
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
         --  Bare `raise` inside a handler re-raises *this* occurrence -- the same exception,
         --  carrying the same message and the same place it came from.
         raise;

      when E : others =>
         Put_Line (Exception_Message (E));
         --  A different exception entirely: the caller is told something went wrong here,
         --  rather than being handed whatever the inside happened to raise.
         raise Another_Exception with "Another_Exception raised!";
   end Check_Exception;

end Re_Raising_Exceptions;
