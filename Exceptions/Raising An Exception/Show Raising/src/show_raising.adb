with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

procedure Show_Raising is
   My_Except : exception;
begin
   --  `raise` abandons the current flow. Everything after it in this block is skipped, and the
   --  exception travels outward until something handles it.
   begin
      raise My_Except;
      Put_Line ("never printed");
   exception
      when E : My_Except =>
         --  With no message given, GNAT supplies the source location of the raise. Useful, and
         --  not something to rely on: the language does not require any particular text here.
         Put_Line ("no message given: [" & Exception_Message (E) & "]");
   end;

   --  `with` attaches a message, which travels with the occurrence.
   begin
      raise My_Except with "the file was not where it should have been";
   exception
      when E : My_Except =>
         Put_Line ("with message: [" & Exception_Message (E) & "]");
   end;

   --  `when E : ...` binds the occurrence to a name, and Ada.Exceptions reads it.
   begin
      raise My_Except with "and again";
   exception
      when E : others =>
         Put_Line ("name:    " & Exception_Name (E));
         Put_Line ("message: " & Exception_Message (E));
   end;
end Show_Raising;
