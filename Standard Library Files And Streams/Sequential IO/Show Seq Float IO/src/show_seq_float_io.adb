with Ada.Text_IO;
with Ada.Sequential_IO;

--  Binary rather than text, and one type per file. Ada.Sequential_IO is generic, so the type is
--  chosen at instantiation and the file can hold nothing else.
procedure Show_Seq_Float_IO is
   package Float_IO is new Ada.Sequential_IO (Float);
   use Float_IO;

   F         : Float_IO.File_Type;
   File_Name : constant String := "show_seq_float_io.bin";
begin
   --  Create, Open, Close, Reset, Delete and End_Of_File are the same as for text. Write and
   --  Read replace Put_Line and Get_Line.
   Create (F, Out_File, File_Name);
   Write (F, 1.5);
   Write (F, 2.4);
   Write (F, 6.7);
   Close (F);

   declare
      Value : Float;
   begin
      Open (F, In_File, File_Name);
      while not End_Of_File (F) loop
         --  Read takes the variable as an out parameter rather than returning it, because the
         --  element type may be anything at all and returning a limited type is not allowed.
         Read (F, Value);
         Ada.Text_IO.Put_Line (Float'Image (Value));
      end loop;

      Delete (F);
   end;
end Show_Seq_Float_IO;
