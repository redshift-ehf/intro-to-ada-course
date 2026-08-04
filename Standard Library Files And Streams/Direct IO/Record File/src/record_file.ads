--  Sequential I/O and direct I/O over the same record type, so the difference between them is
--  the only thing that varies.
--
--  An original exercise: AdaCore's Laboratories has no chapter for Files & Streams. See
--  course-info.yaml for which chapters carry original work.
package Record_File is

   type Reading is record
      Valid : Boolean := False;
      Value : Float   := 0.0;
   end record;

   type Readings is array (Positive range <>) of Reading;

   --  Writes every reading to File_Name in order, then reads them all back. Sequential I/O is
   --  enough for this: it goes forward, once, in each direction.
   function Round_Trip (File_Name : String; Data : Readings) return Readings;

   --  Writes every reading, then replaces the one at Position without rewriting the others, and
   --  returns what the file then holds. Position counts elements from 1.
   --
   --  This one needs direct I/O, because it has to go back.
   function Overwrite_At (File_Name : String;
                          Data      : Readings;
                          Position  : Positive;
                          Value     : Reading) return Readings;

end Record_File;
