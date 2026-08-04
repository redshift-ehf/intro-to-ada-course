with Ada.Text_IO; use Ada.Text_IO;

--  Two things that go wrong with files, and what they raise.
procedure Show_Text_File_Except is
   F         : File_Type;
   File_Name : constant String := "show_text_file_except.txt";
begin
   --  Reset erases everything written so far and starts again at the beginning. The first line
   --  below does not survive it.
   Create (F, Out_File, File_Name);
   Put_Line (F, "Hello World #1");
   Reset (F);
   Put_Line (F, "Hello World #2");
   Close (F);

   Put_Line ("After Reset, the file contains:");
   Open (F, In_File, File_Name);
   while not End_Of_File (F) loop
      Put_Line ("  " & Get_Line (F));
   end loop;

   --  Delete it, then try to open it. Open on a file that is not there raises Name_Error, and
   --  there is no "does this file exist" function to check with first -- handling the exception
   --  is the way this is done.
   Delete (F);

   New_Line;
   begin
      Open (F, In_File, File_Name);
      Close (F);
      Put_Line ("not reached");
   exception
      when Name_Error =>
         Put_Line ("File does not exist");
      when others =>
         Put_Line ("Error while processing input file");
   end;

   --  Status_Error is the other common one: an operation on a file that is not open.
   begin
      Put_Line (F, "nowhere to go");
   exception
      when Status_Error =>
         Put_Line ("Status_Error -- F was closed by Delete");
   end;
end Show_Text_File_Except;
