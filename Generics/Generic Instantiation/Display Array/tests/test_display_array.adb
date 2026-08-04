with Ada.Command_Line;
with Ada_Check;
with Display_Array;

procedure Test_Display_Array is

   --  First instantiation: a plain integer array.
   type Index is range 1 .. 5;
   type Int_Array is array (Index range <>) of Integer;

   function Int_Image (E : Integer) return String is (Integer'Image (E));

   procedure Show_Ints is new Display_Array
     (T_Range => Index, T_Element => Integer, T_Array => Int_Array, Image => Int_Image);

   Numbers : constant Int_Array := (1, 2, 5, 7, 10);

   --  Second instantiation: a record element and a different index range, from the same
   --  generic and with no change to it.
   type Point is record
      X, Y : Float;
   end record;

   type Point_Index is range 0 .. 3;
   type Point_Array is array (Point_Index range <>) of Point;

   function Point_Image (E : Point) return String is
     ("(" & Float'Image (E.X) & "," & Float'Image (E.Y) & ")");

   procedure Show_Points is new Display_Array
     (T_Range => Point_Index, T_Element => Point, T_Array => Point_Array,
      Image => Point_Image);

   Points : constant Point_Array :=
     ((1.0, 0.5), (2.0, -0.5), (5.0, 2.0), (-0.5, 2.0));

   function Ints_Shown return String is
      procedure Call is
      begin
         Show_Ints ("Integers", Numbers);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Ints_Shown;

   function Points_Shown return String is
      procedure Call is
      begin
         Show_Points ("Points", Points);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Points_Shown;
begin
   Ada_Check.Suite ("Display Array");

   Ada_Check.Equal
     (Name     => "an array of integers",
      Actual   => Ints_Shown,
      Expected =>
        "Integers" & ASCII.LF
        & " 1:  1" & ASCII.LF
        & " 2:  2" & ASCII.LF
        & " 3:  5" & ASCII.LF
        & " 4:  7" & ASCII.LF
        & " 5:  10");

   --  The same generic, an element type it was never written for, and an index starting at 0.
   Ada_Check.Equal
     (Name     => "an array of records, indexed from zero",
      Actual   => Points_Shown,
      Expected =>
        "Points" & ASCII.LF
        & " 0: ( 1.00000E+00, 5.00000E-01)" & ASCII.LF
        & " 1: ( 2.00000E+00,-5.00000E-01)" & ASCII.LF
        & " 2: ( 5.00000E+00, 2.00000E+00)" & ASCII.LF
        & " 3: (-5.00000E-01, 2.00000E+00)");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Display_Array;
