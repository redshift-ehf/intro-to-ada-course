with Ada.Text_IO;

with Ada.Streams.Stream_IO;
use  Ada.Streams.Stream_IO;

--  Two types in one file, and one of them unbounded. Neither is possible with sequential or
--  direct I/O.
procedure Show_String_Stream is
   F         : File_Type;
   S         : Stream_Access;
   File_Name : constant String := "show_string_stream.bin";

   --  Writing the pair in one place, and reading it in one place, is what keeps the order
   --  right -- and the order is the whole format, because the file does not record it.
   procedure Output (S : Stream_Access; FV : Float; SV : String) is
   begin
      --  'Output, not 'Write: a String's length is not part of its type, so the bounds have to
      --  go into the file as well. 'Write would put the characters and nothing else, and
      --  nothing could read them back.
      String'Output (S, SV);
      Float'Output (S, FV);
   end Output;

   procedure Input_Display (S : Stream_Access) is
      --  'Input is a function, because it has to read the bounds first and then make an object
      --  of that size. 'Read cannot: it takes an object that already exists.
      SV : constant String := String'Input (S);
      FV : constant Float  := Float'Input (S);
   begin
      Ada.Text_IO.Put_Line (Float'Image (FV) & " --- " & SV);
   end Input_Display;
begin
   Create (F, Out_File, File_Name);
   S := Stream (F);

   Output (S, 1.5, "Hi!!");
   Output (S, 2.4, "Hello world!");
   Output (S, 6.7, "Something longer here...");

   Close (F);

   Open (F, In_File, File_Name);
   S := Stream (F);

   while not End_Of_File (F) loop
      Input_Display (S);
   end loop;

   Delete (F);
end Show_String_Stream;
