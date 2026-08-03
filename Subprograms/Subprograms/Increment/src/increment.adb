with Ada.Text_IO; use Ada.Text_IO;

procedure Increment is

   --  A function returns a value; a procedure does not. Both are subprograms.
   --
   --  Parameters can have defaults, so this can be called with two arguments, one, or none.
   function Increment_By
     (I    : Integer := 0;
      Incr : Integer := 1) return Integer is
   begin
      return I + Incr;
   end Increment_By;

   A, B, C : Integer;

   --  A subprogram declared inside another sees the enclosing declarations. Display_Result reads
   --  A, B and C without being passed any of them.
   procedure Display_Result is
   begin
      Put_Line ("Increment of "
                & Integer'Image (A)
                & " with "
                & Integer'Image (B)
                & " is "
                & Integer'Image (C));
   end Display_Result;

begin
   A := 10;
   B := 3;

   --  Positional arguments.
   C := Increment_By (A, B);
   Display_Result;

   A := 20;
   B := 5;

   --  Named arguments. Positional ones must come before named ones, never after.
   C := Increment_By (I => A, Incr => B);
   Display_Result;

   --  Both defaults taken. A parameterless call has no parentheses at all.
   Put_Line ("Increment_By with no arguments is" & Integer'Image (Increment_By));
end Increment;
