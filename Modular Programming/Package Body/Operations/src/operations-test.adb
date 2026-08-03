with Ada.Text_IO; use Ada.Text_IO;

package body Operations.Test is

   procedure Display (A, B : Integer) is
      A_Str : constant String := Integer'Image (A);
      B_Str : constant String := Integer'Image (B);
   begin
      Put_Line ("Operations:");
      --  Add, Subtract and the rest need no qualification: this is a child of Operations.
      Put_Line (A_Str & " + " & B_Str & " = " & Integer'Image (Add (A, B)) & ",");
      Put_Line (A_Str & " - " & B_Str & " = " & Integer'Image (Subtract (A, B)) & ",");
      Put_Line (A_Str & " * " & B_Str & " = " & Integer'Image (Multiply (A, B)) & ",");
      Put_Line (A_Str & " / " & B_Str & " = " & Integer'Image (Divide (A, B)) & ",");
   end Display;

end Operations.Test;
