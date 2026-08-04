with Ada.Text_IO;
with Ada.Sequential_IO;

--  The same package, instantiated for a record instead of a Float. Nothing else changes, which
--  is the point of showing it twice.
procedure Show_Seq_Rec_IO is
   type Num_Info is record
      Valid : Boolean := False;
      Value : Float   := 0.0;
   end record;

   procedure Put_Line (N : Num_Info) is
   begin
      if N.Valid then
         Ada.Text_IO.Put_Line ("(ok,     " & Float'Image (N.Value) & ")");
      else
         Ada.Text_IO.Put_Line ("(not ok,  -----------)");
      end if;
   end Put_Line;

   package Num_Info_IO is new Ada.Sequential_IO (Num_Info);
   use Num_Info_IO;

   F         : Num_Info_IO.File_Type;
   File_Name : constant String := "show_seq_rec_io.bin";
begin
   Create (F, Out_File, File_Name);
   Write (F, (True,  1.5));
   Write (F, (False, 2.4));
   Write (F, (True,  6.7));
   Close (F);

   declare
      Value : Num_Info;
   begin
      Open (F, In_File, File_Name);
      while not End_Of_File (F) loop
         Read (F, Value);
         Put_Line (Value);
      end loop;

      Delete (F);
   end;

   --  What it cannot do: a second type in the same file. The instantiation fixed that, and
   --  Stream I/O two lessons from now is the answer.
end Show_Seq_Rec_IO;
