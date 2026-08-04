with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

--  Two types in one file, one of them of a length the file has to record for itself.
--
--  An original exercise: AdaCore's Laboratories has no chapter for Files & Streams. See
--  course-info.yaml for which chapters carry original work.
package Mixed_Stream is

   type Labels is array (Positive range <>) of Unbounded_String;
   type Values is array (Positive range <>) of Float;

   --  Writes each label and then its value into one stream file, reads the file back, and
   --  returns one line per pair:
   --
   --     first = 1.50000E+00
   --     second = 2.40000E+00
   --
   --  The last line has no newline after it. L and V must be the same length; the file is left
   --  where it was written.
   function Round_Trip (File_Name : String;
                        L         : Labels;
                        V         : Values) return String;

end Mixed_Stream;
