with Ada.Text_IO;

with Ada.Streams.Stream_IO;
use  Ada.Streams.Stream_IO;

--  Stream I/O is not generic and is not tied to one type. You do not go through the File_Type to
--  read and write -- you take a Stream_Access from it, and the *type's* own attributes do the
--  work.
procedure Show_Float_Stream is
   F         : File_Type;
   S         : Stream_Access;
   File_Name : constant String := "show_float_stream.bin";
begin
   Create (F, Out_File, File_Name);
   S := Stream (F);

   --  'Write and 'Read, on the type. Every type has them, so a stream file can hold anything.
   Float'Write (S, 1.5);
   Float'Write (S, 2.4);
   Float'Write (S, 6.7);

   Close (F);

   declare
      Value : Float;
   begin
      Open (F, In_File, File_Name);
      S := Stream (F);

      while not End_Of_File (F) loop
         Float'Read (S, Value);
         Ada.Text_IO.Put_Line (Float'Image (Value));
      end loop;

      Delete (F);
   end;

   --  Nothing in the file says what type any of it was. Read it back as something else and you
   --  get whatever those bytes happen to mean -- the one place in Ada where strong typing is no
   --  help at all.
end Show_Float_Stream;
