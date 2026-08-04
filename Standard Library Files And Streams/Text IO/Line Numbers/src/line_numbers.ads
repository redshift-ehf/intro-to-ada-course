with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

--  Write a text file, read it back, and number what comes out.
--
--  An original exercise: AdaCore's Laboratories has no chapter for Files & Streams. See
--  course-info.yaml for which chapters carry original work.
package Line_Numbers is

   type Lines is array (Positive range <>) of Unbounded_String;

   --  Writes one line per element to File_Name, then reads the file back and returns every line
   --  with its number and a colon in front:
   --
   --     1: first
   --     2: second
   --
   --  The last line has no newline after it. The file is left where it was written -- deleting
   --  it is the caller's business.
   function Numbered (File_Name : String; Content : Lines) return String;

   --  How many lines File_Name has. Raises Ada.Text_IO.Name_Error if it is not there.
   function Line_Count (File_Name : String) return Natural;

end Line_Numbers;
