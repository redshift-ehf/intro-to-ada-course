with Ada.Text_IO; use Ada.Text_IO;

procedure Counting is
   I : Integer := 1;
begin
   Put_Line ("A for loop, counting up:");
   for J in 1 .. 5 loop
      Put_Line ("  Hello, World!" & Integer'Image (J));
   end loop;

   Put_Line ("The same in reverse:");
   for J in reverse 1 .. 5 loop
      Put_Line ("  Hello, World!" & Integer'Image (J));
   end loop;

   Put_Line ("A range whose end is below its start runs zero times:");
   for J in reverse 5 .. 1 loop
      Put_Line ("  you will not see this" & Integer'Image (J));
   end loop;

   Put_Line ("A bare loop, which exits when it is told to:");
   loop
      Put_Line ("  Hello, World!" & Integer'Image (I));
      exit when I = 5;
      I := I + 1;
   end loop;

   Put_Line ("A while loop, which tests before each turn:");
   I := 1;
   while I <= 5 loop
      Put_Line ("  Hello, World!" & Integer'Image (I));
      I := I + 1;
   end loop;
end Counting;
