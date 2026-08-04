with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Aggregate_Forms is
   type Point is record
      X, Y : Integer := 0;
   end record;

   type Point_Array is array (Positive range <>) of Point;

   --  An aggregate must give a value for every component, including ones that have a default.
   --  `(X => 0)` on its own is rejected: Y is missing, and its default does not fill the gap.
   --
   --  These four shortcuts are what make that rule comfortable to live with.

   Origin   : constant Point := (X | Y => <>);   --  `|`      several components at once
   Origin_2 : constant Point := (others => <>);  --  `others` everything not named yet
                                                 --  `<>`     the component's own default

   Points_1 : constant Point_Array := ((1, 2), (3, 4));

   Points_2 : constant Point_Array :=
     (1       => (1, 2),
      2       => (3, 4),
      3 .. 20 => <>);                            --  `..`     a run of indices

   procedure Show (Name : String; P : Point) is
   begin
      Put_Line (Name & ": X =>" & Integer'Image (P.X)
                & ", Y =>" & Integer'Image (P.Y));
   end Show;
begin
   Show ("Origin      ", Origin);
   Show ("Origin_2    ", Origin_2);
   Show ("Points_1 (1)", Points_1 (1));
   Show ("Points_1 (2)", Points_1 (2));
   Show ("Points_2 (2)", Points_2 (2));

   --  Everything from 3 to 20 took the default, so this is (0, 0).
   Show ("Points_2 (20)", Points_2 (20));

   Put_Line ("Points_2 runs" & Integer'Image (Points_2'First)
             & " .." & Integer'Image (Points_2'Last));
end Show_Aggregate_Forms;
