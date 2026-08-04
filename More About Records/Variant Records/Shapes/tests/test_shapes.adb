with Ada.Command_Line;
with Ada_Check;
with Shapes;

procedure Test_Shapes is
   use Shapes;

   Round : constant Shape := (Kind => Circle, Radius => 2.0);
   Boxy  : constant Shape := (Kind => Rectangle, Width => 3.0, Height => 4.0);
   Wedge : constant Shape := (Kind => Triangle, Base => 6.0, Vertical => 5.0);
begin
   Ada_Check.Suite ("Shapes");

   Ada_Check.Equal ("a circle of radius 2", Area (Round), 12.566371, Tolerance => 0.0001);
   Ada_Check.Equal ("a 3 by 4 rectangle",   Area (Boxy),  12.0);
   Ada_Check.Equal ("a 6 by 5 triangle",    Area (Wedge), 15.0);

   Ada_Check.Equal ("circle name",    Name (Round), "Circle");
   Ada_Check.Equal ("rectangle name", Name (Boxy),  "Rectangle");
   Ada_Check.Equal ("triangle name",  Name (Wedge), "Triangle");

   Ada_Check.Check ("a circle is round",       Is_Round (Round));
   Ada_Check.Check ("a rectangle is not",      not Is_Round (Boxy));
   Ada_Check.Check ("and neither is a wedge",  not Is_Round (Wedge));

   --  A degenerate shape is still a shape, and the arithmetic should not special-case it.
   declare
      Flat : constant Shape := (Kind => Rectangle, Width => 0.0, Height => 7.0);
      Dot  : constant Shape := (Kind => Circle, Radius => 0.0);
   begin
      Ada_Check.Equal ("a rectangle with no width", Area (Flat), 0.0);
      Ada_Check.Equal ("a circle with no radius",   Area (Dot),  0.0);
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Shapes;
