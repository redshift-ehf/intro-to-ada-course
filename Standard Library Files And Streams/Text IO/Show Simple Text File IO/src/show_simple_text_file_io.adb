with Ada.Text_IO; use Ada.Text_IO;

--  A text file is the same thing standard output is: a File_Type that Put_Line accepts. Only
--  Create and Open are new.
procedure Show_Simple_Text_File_IO is
   F         : File_Type;
   File_Name : constant String := "show_simple_text_file_io.txt";
begin
   --  Create makes a new file, truncating any existing one, and leaves F open for writing.
   Create (F, Out_File, File_Name);
   Put_Line (F, "Hello World #1");
   Put_Line (F, "Hello World #2");
   Put_Line (F, "Hello World #3");
   Close (F);

   --  Open wants a mode too. In_File to read.
   Open (F, In_File, File_Name);
   while not End_Of_File (F) loop
      Put_Line (Get_Line (F));
   end loop;
   Close (F);

   --  Append_File is the third mode: open an existing file and write past the end of it.
   Open (F, Append_File, File_Name);
   Put_Line (F, "Hello World #4");
   Close (F);

   New_Line;
   Put_Line ("After appending:");
   Open (F, In_File, File_Name);
   while not End_Of_File (F) loop
      Put_Line (Get_Line (F));
   end loop;

   --  Delete takes the open file and removes it, which is also how this example leaves nothing
   --  behind. F cannot be used afterwards.
   Delete (F);
end Show_Simple_Text_File_IO;
