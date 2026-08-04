with Ada.Command_Line;
with Ada.Directories;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada_Check;
with Mixed_Stream;

procedure Test_Mixed_Stream is
   use Mixed_Stream;

   Name : constant String := "test_mixed_stream.tmp";

   function U (S : String) return Unbounded_String renames To_Unbounded_String;

   procedure Remove is
   begin
      if Ada.Directories.Exists (Name) then
         Ada.Directories.Delete_File (Name);
      end if;
   end Remove;
begin
   Ada_Check.Suite ("Mixed stream");

   --  Three labels of three different lengths, which is what makes 'Output necessary.
   Ada_Check.Equal
     (Name     => "labels of different lengths, and their values",
      Actual   => Round_Trip (Name,
                              (U ("Hi!!"), U ("Hello world!"), U ("Something longer here...")),
                              (1.5, 2.4, 6.7)),
      Expected => "Hi!! = " & Float'Image (1.5) & ASCII.LF
                  & "Hello world! = " & Float'Image (2.4) & ASCII.LF
                  & "Something longer here... = " & Float'Image (6.7));

   --  One pair, so no separator -- the case that catches a trailing newline.
   Ada_Check.Equal ("one pair",
                    Round_Trip (Name, (1 => U ("only")), (1 => 9.9)),
                    "only = " & Float'Image (9.9));

   --  Nothing in, nothing out.
   declare
      No_Labels : constant Labels (1 .. 0) := (1 .. 0 => Null_Unbounded_String);
      No_Values : constant Values (1 .. 0) := (1 .. 0 => 0.0);
   begin
      Ada_Check.Equal ("no pairs at all", Round_Trip (Name, No_Labels, No_Values), "");
   end;

   --  An empty label has a length too, and 'Output records it.
   Ada_Check.Equal ("an empty label",
                    Round_Trip (Name, (1 => U ("")), (1 => 0.0)),
                    " = " & Float'Image (0.0));

   --  Bounds that do not start at 1. Both arrays are walked by offset, not by index.
   declare
      L : constant Labels (5 .. 6) := (U ("a"), U ("bb"));
      V : constant Values (9 .. 10) := (1.0, 2.0);
   begin
      Ada_Check.Equal
        (Name     => "arrays with different bounds",
         Actual   => Round_Trip (Name, L, V),
         Expected => "a = " & Float'Image (1.0) & ASCII.LF
                     & "bb = " & Float'Image (2.0));
   end;

   --  Writing again truncates: the second call must not read the first call's pairs.
   Ada_Check.Equal ("writing again replaces",
                    Round_Trip (Name, (1 => U ("x")), (1 => 1.0)),
                    "x = " & Float'Image (1.0));

   --  A label with the separator in it comes back whole -- the length in the file is what ends
   --  it, not any character.
   Ada_Check.Equal ("a label containing a newline",
                    Round_Trip (Name, (1 => U ("two" & ASCII.LF & "lines")), (1 => 3.0)),
                    "two" & ASCII.LF & "lines = " & Float'Image (3.0));

   Remove;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Mixed_Stream;
