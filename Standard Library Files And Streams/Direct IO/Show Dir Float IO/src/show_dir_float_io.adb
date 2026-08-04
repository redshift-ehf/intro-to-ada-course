with Ada.Text_IO;
with Ada.Direct_IO;

--  Ada.Direct_IO is Ada.Sequential_IO with a position you can move. Replacing one package name
--  with the other is the whole of the first half of this program.
procedure Show_Dir_Float_IO is
   package Float_IO is new Ada.Direct_IO (Float);
   use Float_IO;

   F         : Float_IO.File_Type;
   File_Name : constant String := "show_dir_float_io.bin";
begin
   --  Inout_File reads and writes through one File_Type. Direct I/O has no Append_File -- with
   --  an index you can move, it does not need one.
   Create (F, Inout_File, File_Name);
   Write (F, 1.5);
   Write (F, 2.4);
   Write (F, 6.7);

   --  Index is where the next operation will happen, counted in elements from 1 -- not in
   --  bytes. After three writes it is 4, so this steps back onto the third.
   Ada.Text_IO.Put_Line ("Index after three writes:" & Count'Image (Index (F)));

   Set_Index (F, Index (F) - 1);
   Write (F, 7.7);

   declare
      Value : Float;
   begin
      --  Back to the start, rather than closing and reopening.
      Set_Index (F, 1);

      while not End_Of_File (F) loop
         Read (F, Value);
         Ada.Text_IO.Put_Line (Float'Image (Value));
      end loop;

      Ada.Text_IO.Put_Line ("Size:" & Count'Image (Size (F)) & " elements");

      Delete (F);
   end;
end Show_Dir_Float_IO;
