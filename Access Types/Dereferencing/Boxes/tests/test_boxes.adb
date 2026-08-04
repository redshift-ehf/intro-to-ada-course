with Ada.Command_Line;
with Ada_Check;
with Boxes;

procedure Test_Boxes is
   use Boxes;

   A : constant Int_Box := Make (10);
   B : constant Int_Box := Make (20);
begin
   Ada_Check.Suite ("Boxes");

   Ada_Check.Equal ("Make keeps the value", Get (A), 10);
   Ada_Check.Equal ("and the other one",    Get (B), 20);

   Ada_Check.Check ("a made box is not empty", not Is_Empty (A));
   Ada_Check.Check ("null is empty",           Is_Empty (null));

   Set (A, 99);
   Ada_Check.Equal ("Set changes what the box holds", Get (A), 99);
   Ada_Check.Equal ("and leaves the other alone",     Get (B), 20);

   Swap (A, B);
   Ada_Check.Equal ("Swap moves B's value into A", Get (A), 20);
   Ada_Check.Equal ("and A's into B",              Get (B), 99);

   --  The crux of this exercise: Swap exchanges the Integers, not the boxes. Both names still
   --  designate the objects they always did, so a second name for A sees the swapped value.
   declare
      Also_A : constant Int_Box := A;
   begin
      Ada_Check.Equal ("a second name sees the same object", Get (Also_A), 20);
      Set (Also_A, 7);
      Ada_Check.Equal ("and writes through to it", Get (A), 7);
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Boxes;
