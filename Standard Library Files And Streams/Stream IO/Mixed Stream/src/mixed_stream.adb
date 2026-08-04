with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package body Mixed_Stream is

   function Round_Trip (File_Name : String;
                        L         : Labels;
                        V         : Values) return String
   is
      F      : File_Type;
      S      : Stream_Access;
      Result : Unbounded_String := Null_Unbounded_String;
      N      : Natural          := 0;
   begin
      Create (F, Out_File, File_Name);
      S := Stream (F);

      for I in 0 .. L'Length - 1 loop
         --  'Output rather than 'Write: the labels are different lengths, so the bounds have to
         --  go into the file too. Float is definite, so 'Write is enough for the value -- as
         --  long as the reader uses 'Read to match.
         String'Output (S, To_String (L (L'First + I)));
         Float'Write (S, V (V'First + I));
      end loop;

      Close (F);

      Open (F, In_File, File_Name);
      S := Stream (F);

      while not End_Of_File (F) loop
         declare
            --  The same order as the writing, because the file does not record it.
            Label : constant String := String'Input (S);
            Value : Float;
         begin
            Float'Read (S, Value);

            N := N + 1;
            if N > 1 then
               Append (Result, ASCII.LF);
            end if;
            Append (Result, Label & " = " & Float'Image (Value));
         end;
      end loop;

      Close (F);

      return To_String (Result);
   end Round_Trip;

end Mixed_Stream;
