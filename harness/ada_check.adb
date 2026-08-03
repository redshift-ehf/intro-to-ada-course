with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;

package body Ada_Check is

   use Ada.Strings.Unbounded;

   Fail_Count : Natural := 0;
   Open_Suite : Unbounded_String;

   --  Character-wise, which is why there is no "escape the escape first" problem here: a
   --  sequential set of string replacements would double-escape its own output unless '|' went
   --  first, but a single pass over the input cannot.
   function Escape (Text : String) return String is
      Result : Unbounded_String;
   begin
      for C of Text loop
         case C is
            when '|'      => Append (Result, "||");
            when '''      => Append (Result, "|'");
            when '['      => Append (Result, "|[");
            when ']'      => Append (Result, "|]");
            when ASCII.LF => Append (Result, "|n");
            when ASCII.CR => Append (Result, "|r");
            when others   => Append (Result, C);
         end case;
      end loop;
      return To_String (Result);
   end Escape;

   function Image (Value : Integer) return String is
     (Ada.Strings.Fixed.Trim (Value'Image, Ada.Strings.Both));

   function Image (Value : Float) return String is
     (Ada.Strings.Fixed.Trim (Value'Image, Ada.Strings.Both));

   function Location (File : String; Line : Natural) return String is
   begin
      if File = "" or else Line = 0 then
         return "";
      end if;
      return " locationHint='file://" & Escape (File) & ":" & Image (Line) & "'";
   end Location;

   procedure Emit (Message : String) renames Ada.Text_IO.Put_Line;

   procedure Suite (Name : String) is
   begin
      Emit ("##teamcity[enteredTheMatrix]");
      Open_Suite := To_Unbounded_String (Name);
      Emit ("##teamcity[testSuiteStarted name='" & Escape (Name) & "']");
   end Suite;

   procedure Finish is
   begin
      Emit ("##teamcity[testSuiteFinished name='" & Escape (To_String (Open_Suite)) & "']");
   end Finish;

   --  duration is 0 and honestly so: the condition was evaluated before Check was called, so
   --  there is nothing here to time.
   procedure Started (Name : String; File : String; Line : Natural) is
   begin
      Emit ("##teamcity[testStarted name='" & Escape (Name) & "'" & Location (File, Line) & "]");
   end Started;

   procedure Ended (Name : String) is
   begin
      Emit ("##teamcity[testFinished name='" & Escape (Name) & "' duration='0']");
   end Ended;

   procedure Check
     (Name      : String;
      Condition : Boolean;
      Detail    : String  := "";
      File      : String  := GNAT.Source_Info.File;
      Line      : Natural := GNAT.Source_Info.Line) is
   begin
      Started (Name, File, Line);
      if not Condition then
         Fail_Count := Fail_Count + 1;
         Emit ("##teamcity[testFailed name='" & Escape (Name)
               & "' message='check failed' details='" & Escape (Detail) & "']");
      end if;
      --  testFinished must follow testFailed: the converter pops the suite stack on it alone.
      Ended (Name);
   end Check;

   --  The comparison form, which the IDE turns into a real diff rather than a line of prose.
   procedure Compared
     (Name     : String;
      Actual   : String;
      Expected : String) is
   begin
      Fail_Count := Fail_Count + 1;
      Emit ("##teamcity[testFailed name='" & Escape (Name)
            & "' message='comparison failed' details='' type='comparisonFailure'"
            & " expected='" & Escape (Expected) & "' actual='" & Escape (Actual) & "']");
   end Compared;

   procedure Equal
     (Name     : String;
      Actual   : String;
      Expected : String;
      File     : String  := GNAT.Source_Info.File;
      Line     : Natural := GNAT.Source_Info.Line) is
   begin
      Started (Name, File, Line);
      if Actual /= Expected then
         Compared (Name, Actual, Expected);
      end if;
      Ended (Name);
   end Equal;

   procedure Equal
     (Name     : String;
      Actual   : Integer;
      Expected : Integer;
      File     : String  := GNAT.Source_Info.File;
      Line     : Natural := GNAT.Source_Info.Line) is
   begin
      Started (Name, File, Line);
      if Actual /= Expected then
         Compared (Name, Image (Actual), Image (Expected));
      end if;
      Ended (Name);
   end Equal;

   procedure Equal
     (Name      : String;
      Actual    : Float;
      Expected  : Float;
      Tolerance : Float   := 1.0e-3;
      File      : String  := GNAT.Source_Info.File;
      Line      : Natural := GNAT.Source_Info.Line) is
   begin
      Started (Name, File, Line);
      if abs (Actual - Expected) > Tolerance then
         --  Reported with the full image rather than the rounded one: when a float assertion
         --  fails, the digits that differ are usually the ones a shortened image would drop.
         Compared (Name, Image (Actual), Image (Expected));
      end if;
      Ended (Name);
   end Equal;

   function Failures return Natural is (Fail_Count);

   function Output_Of (Run : access procedure) return String is
      Captured : Ada.Text_IO.File_Type;
      Path     : constant String := "obj/ada_check_capture.txt";
      Result   : Unbounded_String;
   begin
      --  Redirect, run, restore. The restore must happen even if the student's code raises, or
      --  every later service message in this suite would go into the capture file instead of to
      --  the IDE, and the test tree would simply stop updating with no error to explain it.
      Ada.Text_IO.Create (Captured, Ada.Text_IO.Out_File, Path);
      Ada.Text_IO.Set_Output (Captured);
      begin
         Run.all;
      exception
         when others =>
            Ada.Text_IO.Set_Output (Ada.Text_IO.Standard_Output);
            Ada.Text_IO.Close (Captured);
            raise;
      end;
      Ada.Text_IO.Set_Output (Ada.Text_IO.Standard_Output);
      Ada.Text_IO.Close (Captured);

      Ada.Text_IO.Open (Captured, Ada.Text_IO.In_File, Path);
      while not Ada.Text_IO.End_Of_File (Captured) loop
         Append (Result, Ada.Text_IO.Get_Line (Captured));
         if not Ada.Text_IO.End_Of_File (Captured) then
            Append (Result, ASCII.LF);
         end if;
      end loop;
      Ada.Text_IO.Close (Captured);

      --  The final line break is not included, so a test can say what was printed without also
      --  having to say how it ended.
      return To_String (Result);
   end Output_Of;

   --  Each of these is the nested-procedure dance written once, here, instead of at every call
   --  site. Nothing else is going on: Call closes over the argument and the general form does
   --  the capturing.

   function Output_Of
     (Run : access procedure (Item : String); Arg : String) return String
   is
      procedure Call is
      begin
         Run (Arg);
      end Call;
   begin
      return Output_Of (Call'Access);
   end Output_Of;

   function Output_Of
     (Run : access procedure (Item : Integer); Arg : Integer) return String
   is
      procedure Call is
      begin
         Run (Arg);
      end Call;
   begin
      return Output_Of (Call'Access);
   end Output_Of;

   function Output_Of
     (Run : access procedure (First, Second : Integer); A, B : Integer) return String
   is
      procedure Call is
      begin
         Run (A, B);
      end Call;
   begin
      return Output_Of (Call'Access);
   end Output_Of;

end Ada_Check;
