with Ada.Strings;       use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO;       use Ada.Text_IO;

package body Line_Numbers is

   --  Natural'Image brings a leading space and this format has none. Given, because it belongs
   --  to the Strings chapter rather than this one.
   function Number_Image (N : Natural) return String is
     (Trim (Natural'Image (N), Left));

   function Numbered (File_Name : String; Content : Lines) return String is
      F      : File_Type;
      Result : Unbounded_String := Null_Unbounded_String;
      N      : Natural          := 0;
   begin
      --  Out_File truncates an existing file, so this starts clean whatever was there.
      Create (F, Out_File, File_Name);
      for Line of Content loop
         Put_Line (F, To_String (Line));
      end loop;
      Close (F);

      Open (F, In_File, File_Name);
      while not End_Of_File (F) loop
         declare
            Line : constant String := Get_Line (F);
         begin
            N := N + 1;

            --  A separator before every line but the first, which is how the last one ends up
            --  without a trailing newline.
            if N > 1 then
               Append (Result, ASCII.LF);
            end if;

            Append (Result, Number_Image (N) & ": " & Line);
         end;
      end loop;
      Close (F);

      return To_String (Result);
   end Numbered;

   function Line_Count (File_Name : String) return Natural is
      F : File_Type;
      N : Natural := 0;
   begin
      Open (F, In_File, File_Name);
      while not End_Of_File (F) loop
         declare
            Ignored : constant String := Get_Line (F);
            pragma Unreferenced (Ignored);
         begin
            N := N + 1;
         end;
      end loop;
      Close (F);

      return N;
   end Line_Count;

end Line_Numbers;
