with Ada.Direct_IO;
with Ada.Sequential_IO;

package body Record_File is

   package Reading_Sequential_IO is new Ada.Sequential_IO (Reading);
   package Reading_Direct_IO     is new Ada.Direct_IO (Reading);

   function Round_Trip (File_Name : String; Data : Readings) return Readings is
      use Reading_Sequential_IO;

      F      : Reading_Sequential_IO.File_Type;
      Result : Readings (Data'Range);
      I      : Positive := Result'First;
   begin
      Create (F, Out_File, File_Name);
      for R of Data loop
         Write (F, R);
      end loop;
      Close (F);

      Open (F, In_File, File_Name);
      while not End_Of_File (F) loop
         --  Read takes the element as an out parameter rather than returning it.
         Read (F, Result (I));
         exit when I = Result'Last;
         I := I + 1;
      end loop;
      Close (F);

      return Result;
   end Round_Trip;

   function Overwrite_At (File_Name : String;
                          Data      : Readings;
                          Position  : Positive;
                          Value     : Reading) return Readings
   is
      use Reading_Direct_IO;

      F      : Reading_Direct_IO.File_Type;
      Result : Readings (Data'Range);
      I      : Positive := Result'First;
   begin
      --  Inout_File, so one File_Type does both directions and nothing has to be reopened.
      Create (F, Inout_File, File_Name);
      for R of Data loop
         Write (F, R);
      end loop;

      --  The index counts elements from 1, and Position is an offset into Data -- so this is
      --  where the two numbering schemes have to be reconciled.
      Set_Index (F, Count (Position - Data'First + 1));
      Write (F, Value);

      Set_Index (F, 1);
      while not End_Of_File (F) loop
         Read (F, Result (I));
         exit when I = Result'Last;
         I := I + 1;
      end loop;
      Close (F);

      return Result;
   end Overwrite_At;

end Record_File;
