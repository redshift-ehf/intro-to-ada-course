with Ada.Text_IO; use Ada.Text_IO;

procedure Numbers (A, B : Integer) is
   First : constant Integer := Integer'Min (A, B);
   Last  : constant Integer := Integer'Max (A, B);
begin
   for I in First .. Last loop
      Put_Line (Integer'Image (I));
   end loop;
end Numbers;
