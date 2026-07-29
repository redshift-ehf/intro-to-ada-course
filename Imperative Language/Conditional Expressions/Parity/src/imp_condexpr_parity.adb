with Ada.Text_IO; use Ada.Text_IO;

procedure Imp_Condexpr_Parity is
   N : constant Integer := 7;

   --  An if EXPRESSION, which has a value, rather than an if statement, which does something.
   S : constant String :=
     (if N > 0 then " is a positive number" else " is not a positive number");
begin
   Put_Line (Integer'Image (N) & S);

   for I in 1 .. 6 loop
      Put_Line (Integer'Image (I) & " is "
                & (if I mod 2 = 0 then "even" else "odd"));
   end loop;

   for I in 1 .. 4 loop
      Put_Line (Integer'Image (I) & " is "
                & (case I is
                      when 1      => "the first",
                      when 2      => "the second",
                      when others => "further along"));
   end loop;
end Imp_Condexpr_Parity;
