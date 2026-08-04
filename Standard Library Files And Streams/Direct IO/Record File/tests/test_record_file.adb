with Ada.Command_Line;
with Ada.Directories;
with Ada_Check;
with Record_File;

procedure Test_Record_File is
   use Record_File;

   Name : constant String := "test_record_file.tmp";

   Data : constant Readings :=
     ((True, 1.5), (False, 2.4), (True, 6.7), (True, 0.0));

   procedure Remove is
   begin
      if Ada.Directories.Exists (Name) then
         Ada.Directories.Delete_File (Name);
      end if;
   end Remove;

   function Same (L, R : Readings) return Boolean is
   begin
      if L'Length /= R'Length then
         return False;
      end if;
      for I in 0 .. L'Length - 1 loop
         if L (L'First + I) /= R (R'First + I) then
            return False;
         end if;
      end loop;
      return True;
   end Same;
begin
   Ada_Check.Suite ("Record file");

   --  Sequential: what goes in comes back, in order and unchanged.
   declare
      Got : constant Readings := Round_Trip (Name, Data);
   begin
      Ada_Check.Equal ("the same number of readings", Got'Length, Data'Length);
      Ada_Check.Check ("and the same readings", Same (Got, Data));
      Ada_Check.Check ("including the False one", not Got (Got'First + 1).Valid);
   end;

   --  One reading is fine, and so is none.
   declare
      One : constant Readings := Round_Trip (Name, (1 => (True, 9.9)));
   begin
      Ada_Check.Equal ("one reading", One'Length, 1);
      Ada_Check.Check ("with its value", One (One'First).Value = 9.9);
   end;

   declare
      Nothing : constant Readings (1 .. 0) := (1 .. 0 => (False, 0.0));
      Empty   : constant Readings := Round_Trip (Name, Nothing);
   begin
      Ada_Check.Equal ("no readings at all", Empty'Length, 0);
   end;

   --  Direct: one element replaced in place, the rest untouched.
   declare
      Got : constant Readings := Overwrite_At (Name, Data, 3, (False, 7.7));
   begin
      Ada_Check.Equal ("still four readings", Got'Length, 4);
      Ada_Check.Check ("the third is the new one",
                       Got (Got'First + 2) = Reading'(False, 7.7));
      Ada_Check.Check ("the first is not", Got (Got'First) = Data (Data'First));
      Ada_Check.Check ("nor is the fourth",
                       Got (Got'Last) = Data (Data'Last));
   end;

   --  The first and the last positions, which are where an off-by-one shows.
   declare
      First_Changed : constant Readings := Overwrite_At (Name, Data, 1, (False, -1.0));
      Last_Changed  : constant Readings := Overwrite_At (Name, Data, 4, (False, -4.0));
   begin
      Ada_Check.Check ("overwriting the first",
                       First_Changed (First_Changed'First) = Reading'(False, -1.0));
      Ada_Check.Check ("leaves the second alone",
                       First_Changed (First_Changed'First + 1) = Data (Data'First + 1));
      Ada_Check.Check ("overwriting the last",
                       Last_Changed (Last_Changed'Last) = Reading'(False, -4.0));
      Ada_Check.Check ("leaves the one before it alone",
                       Last_Changed (Last_Changed'Last - 1) = Data (Data'Last - 1));
   end;

   --  An input that does not start at 1, so Position cannot just be used as the file index.
   declare
      Offset : constant Readings (10 .. 12) :=
        ((True, 1.0), (True, 2.0), (True, 3.0));
      Got    : constant Readings := Overwrite_At (Name, Offset, 11, (False, 9.0));
   begin
      Ada_Check.Equal ("the result keeps the input's bounds", Got'First, 10);
      Ada_Check.Check ("and the middle one changed", Got (11) = Reading'(False, 9.0));
      Ada_Check.Check ("while the first did not", Got (10) = Offset (10));
   end;

   Remove;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Record_File;
