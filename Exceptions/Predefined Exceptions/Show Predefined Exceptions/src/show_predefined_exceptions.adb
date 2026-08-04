with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Predefined_Exceptions is
   type Small is range 1 .. 10;

   Numbers : constant array (1 .. 3) of Integer := (1, 2, 3);

   --  Variables rather than literals, so the checks happen while the program runs rather than
   --  being settled by the compiler.
   Past_The_End : Integer := 4;
   Zero         : Integer := 0;

   Result : Integer;
   Value  : Small;
begin
   --  Constraint_Error covers all of these: a value outside its type's range...
   begin
      Value := Small (Past_The_End * 10);
      Put_Line (Small'Image (Value));
   exception
      when Constraint_Error => Put_Line ("Constraint_Error: value out of range");
   end;

   --  ...an index outside an array's bounds...
   begin
      Result := Numbers (Past_The_End);
      Put_Line (Integer'Image (Result));
   exception
      when Constraint_Error => Put_Line ("Constraint_Error: index out of bounds");
   end;

   --  ...and division by zero. Also overflow, and dereferencing null.
   begin
      Result := 10 / Zero;
      Put_Line (Integer'Image (Result));
   exception
      when Constraint_Error => Put_Line ("Constraint_Error: division by zero");
   end;

   Put_Line ("the four built in are Constraint_Error, Program_Error,"
             & " Storage_Error and Tasking_Error");
end Show_Predefined_Exceptions;
