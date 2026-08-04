with Ada.Text_IO; use Ada.Text_IO;

--  Every Put_Line so far has gone to standard output because that is the default. It is a
--  parameter, and there are two other files already open when a program starts.
procedure Show_Std_Text_Out is
begin
   Put_Line (Standard_Output, "Hello World #1");
   Put_Line (Standard_Error,  "Hello World #2");

   --  Which is the same as:
   Put_Line ("Hello World #3");

   --  Current_Output is what Put_Line uses when it is not told. It is not a constant --
   --  Set_Output points it somewhere else, which is how this course's own test harness captures
   --  what an exercise prints.
   Put_Line (Current_Output, "Hello World #4");

   --  Standard_Input is the third, and is what Get_Line reads when it is not told either.
   Put_Line (Standard_Error, "and that one went to stderr, as this line does");
end Show_Std_Text_Out;
