with Ada.Text_IO; use Ada.Text_IO;

--  No `generic` here. The body uses the formals the specification declared.
procedure Display_Array (Header : String; A : T_Array) is
begin
   Put_Line (Header);
   for I in A'Range loop
      Put_Line (T_Range'Image (I) & ": " & Image (A (I)));
   end loop;
end Display_Array;
