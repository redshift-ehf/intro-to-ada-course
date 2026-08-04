with Ada.Text_IO; use Ada.Text_IO;

with Ada.Numerics.Float_Random;
use  Ada.Numerics.Float_Random;

--  Random floats between 0.0 and 1.0. Not generic -- there is one range and one type.
procedure Show_Float_Random is
   G : Generator;
   X : Uniformly_Distributed;
begin
   --  A generator is an object, not a global. Two of them are independent, which is what makes
   --  this usable from more than one task.
   Reset (G);

   Put_Line ("Some random numbers between "
             & Float'Image (Uniformly_Distributed'First)
             & " and "
             & Float'Image (Uniformly_Distributed'Last) & ":");
   for I in 1 .. 5 loop
      X := Random (G);
      Put_Line (Float'Image (X));
   end loop;

   --  Reset with no argument seeds from something time-varying, so every run differs. Reset with
   --  an Integer seeds it explicitly, and the same seed gives the same sequence -- which is what
   --  you want in a test.
   New_Line;
   Put_Line ("Twice from seed 42:");
   declare
      A, B : Generator;
      Same : Boolean := True;
   begin
      Reset (A, 42);
      Reset (B, 42);
      for I in 1 .. 5 loop
         declare
            X : constant Float := Random (A);
            Y : constant Float := Random (B);
         begin
            Put_Line (Float'Image (X) & "  " & Float'Image (Y));
            Same := Same and then X = Y;
         end;
      end loop;
      Put_Line ("Identical: " & Boolean'Image (Same));
   end;

   --  Scaling to another range is arithmetic, not another package: Low + X * (High - Low).
   New_Line;
   Put_Line ("Scaled to 10.0 .. 20.0:");
   for I in 1 .. 3 loop
      Put_Line (Float'Image (10.0 + Random (G) * 10.0));
   end loop;
end Show_Float_Random;
