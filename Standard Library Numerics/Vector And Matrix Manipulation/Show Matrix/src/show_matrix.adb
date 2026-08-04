with Ada.Text_IO; use Ada.Text_IO;

with Ada.Numerics.Real_Arrays;
use  Ada.Numerics.Real_Arrays;

--  Vectors and matrices of Float, with the linear algebra that goes with them.
procedure Show_Matrix is

   procedure Put_Vector (V : Real_Vector) is
   begin
      Put ("    (");
      for I in V'Range loop
         Put (Float'Image (V (I)) & " ");
      end loop;
      Put_Line (")");
   end Put_Vector;

   procedure Put_Matrix (M : Real_Matrix) is
   begin
      for I in M'Range (1) loop
         Put ("    (");
         for J in M'Range (2) loop
            Put (Float'Image (M (I, J)) & " ");
         end loop;
         Put_Line (")");
      end loop;
   end Put_Matrix;

   --  Bounds come from the aggregate. `Real_Matrix (1 .. 2, 1 .. 3) := ...` also works.
   V1 : constant Real_Vector := (1.0, 3.0);
   V2 : constant Real_Vector := (75.0, 11.0);

   M1 : constant Real_Matrix := ((1.0, 5.0, 1.0),
                                 (2.0, 2.0, 1.0));
   M2 : constant Real_Matrix := ((31.0, 11.0, 10.0),
                                 (34.0, 16.0, 11.0),
                                 (32.0, 12.0, 10.0),
                                 (31.0, 13.0, 10.0));
   M3 : constant Real_Matrix := ((1.0, 2.0),
                                 (2.0, 3.0));
begin
   Put_Line ("V1");
   Put_Vector (V1);
   Put_Line ("V2");
   Put_Vector (V2);

   --  Two different "*" on the same operands: vector times vector is the inner product, a
   --  Float; the other is the outer product, a Real_Matrix. Which one runs is decided by what
   --  the result is used as.
   Put_Line ("V1 * V2 = (inner product)");
   Put_Line ("    " & Float'Image (V1 * V2));
   Put_Line ("V1 * V2 = (outer product)");
   Put_Matrix (V1 * V2);
   New_Line;

   Put_Line ("M1");
   Put_Matrix (M1);
   Put_Line ("M2");
   Put_Matrix (M2);
   Put_Line ("M2 * Transpose (M1) =");
   Put_Matrix (M2 * Transpose (M1));
   New_Line;

   Put_Line ("M3");
   Put_Matrix (M3);
   Put_Line ("Inverse (M3) =");
   Put_Matrix (Inverse (M3));
   Put_Line ("Determinant (M3) =");
   Put_Line ("    " & Float'Image (Determinant (M3)));
   Put_Line ("Solve (M3, V1) =");
   Put_Vector (Solve (M3, V1));
   Put_Line ("Eigenvalues (M3) =");
   Put_Vector (Eigenvalues (M3));
   New_Line;

   --  A singular matrix has no inverse, and says so.
   declare
      Singular : constant Real_Matrix := ((1.0, 2.0), (2.0, 4.0));
   begin
      Put_Line ("Determinant of a singular matrix: "
                & Float'Image (Determinant (Singular)));
      Put_Matrix (Inverse (Singular));
   exception
      when Constraint_Error =>
         Put_Line ("Inverse of a singular matrix raises Constraint_Error");
   end;
end Show_Matrix;
