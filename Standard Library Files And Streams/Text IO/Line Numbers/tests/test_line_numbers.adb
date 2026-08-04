with Ada.Command_Line;
with Ada.Directories;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;
with Ada_Check;
with Line_Numbers;

procedure Test_Line_Numbers is
   use Line_Numbers;

   Name : constant String := "test_line_numbers.tmp";

   function U (S : String) return Unbounded_String renames To_Unbounded_String;

   --  Every case leaves a file behind, and the test is what cleans up.
   procedure Remove is
   begin
      if Ada.Directories.Exists (Name) then
         Ada.Directories.Delete_File (Name);
      end if;
   end Remove;
begin
   Ada_Check.Suite ("Line numbers");

   Ada_Check.Equal
     (Name     => "three lines, numbered from one",
      Actual   => Numbered (Name, (U ("first"), U ("second"), U ("third"))),
      Expected => "1: first" & ASCII.LF & "2: second" & ASCII.LF & "3: third");

   Ada_Check.Equal ("and the file has three lines", Line_Count (Name), 3);

   --  One line, so no separator anywhere -- the case that catches a trailing newline.
   Ada_Check.Equal ("one line", Numbered (Name, (1 => U ("only"))), "1: only");
   Ada_Check.Equal ("one line in the file", Line_Count (Name), 1);

   --  Out_File truncates, so the second call must not see the first call's lines.
   Ada_Check.Equal ("writing again replaces, not appends",
                    Numbered (Name, (U ("a"), U ("b"))), "1: a" & ASCII.LF & "2: b");
   Ada_Check.Equal ("two lines now", Line_Count (Name), 2);

   --  Nothing in, nothing out, and an empty file.
   declare
      Nothing : constant Lines (1 .. 0) := (1 .. 0 => Null_Unbounded_String);
   begin
      Ada_Check.Equal ("no lines at all", Numbered (Name, Nothing), "");
      Ada_Check.Equal ("an empty file", Line_Count (Name), 0);
   end;

   --  An empty line is still a line.
   Ada_Check.Equal ("an empty line", Numbered (Name, (U ("x"), U (""), U ("z"))),
                    "1: x" & ASCII.LF & "2: " & ASCII.LF & "3: z");

   --  Past nine, so the number is two characters and nothing pads it.
   declare
      Many : Lines (1 .. 11);
   begin
      for I in Many'Range loop
         Many (I) := U ("line");
      end loop;
      declare
         Got  : constant String := Numbered (Name, Many);
         --  "11: line" is eight characters, so eight back from the end.
         Tail : constant String := Got (Got'Last - 7 .. Got'Last);
      begin
         Ada_Check.Equal ("eleven lines", Line_Count (Name), 11);
         Ada_Check.Equal ("and the eleventh is not padded", Tail, "11: line");
      end;
   end;

   --  Opening a file that is not there raises Name_Error, which is the only way to find out.
   Remove;
   declare
      Raised : Boolean := False;
   begin
      begin
         declare
            Ignored : constant Natural := Line_Count (Name);
            pragma Unreferenced (Ignored);
         begin
            null;
         end;
      exception
         when Ada.Text_IO.Name_Error =>
            Raised := True;
      end;

      Ada_Check.Check ("counting a file that is not there raises Name_Error", Raised);
   end;

   --  Nothing of this test survives it.
   Remove;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Line_Numbers;
