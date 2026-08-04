with Ada.Containers.Vectors;
with Ada.Containers.Ordered_Sets;

with Ada.Text_IO; use Ada.Text_IO;

--  The Reference Manual states the complexity of each container operation. This counts the
--  comparisons instead of quoting the table, by handing each container an operator that keeps
--  a tally.
procedure Show_Complexity is

   N : constant := 1024;

   Vector_Comparisons : Natural := 0;
   Set_Comparisons    : Natural := 0;

   --  The containers call these. Nothing else does.
   function Counted_Equal (L, R : Integer) return Boolean is
   begin
      Vector_Comparisons := Vector_Comparisons + 1;
      return L = R;
   end Counted_Equal;

   function Counted_Less (L, R : Integer) return Boolean is
   begin
      Set_Comparisons := Set_Comparisons + 1;
      return L < R;
   end Counted_Less;

   --  "=" and "<" are generic formals, so an instantiation can supply its own.
   package Integer_Vectors is new
     Ada.Containers.Vectors
       (Index_Type   => Positive,
        Element_Type => Integer,
        "="          => Counted_Equal);

   package Integer_Sets is new
     Ada.Containers.Ordered_Sets
       (Element_Type => Integer,
        "<"          => Counted_Less);

   V : Integer_Vectors.Vector;
   S : Integer_Sets.Set;
begin
   for I in 1 .. N loop
      V.Append (I);
      S.Insert (I);
   end loop;

   --  Building them cost comparisons of its own. Start the count at the search.
   Vector_Comparisons := 0;
   Set_Comparisons    := 0;

   declare
      use type Integer_Sets.Cursor;

      Found_In_Vector : constant Boolean :=
        V.Find_Index (N) /= Integer_Vectors.No_Index;
      Found_In_Set    : constant Boolean :=
        S.Find (N) /= Integer_Sets.No_Element;
   begin
      Put_Line ("Searching" & Integer'Image (N)
                & " elements for the last one.");
      New_Line;
      Put_Line ("Vector.Find_Index found it: " & Boolean'Image (Found_In_Vector)
                & ", after" & Natural'Image (Vector_Comparisons) & " comparisons");
      Put_Line ("Set.Find found it:          " & Boolean'Image (Found_In_Set)
                & ", after" & Natural'Image (Set_Comparisons) & " comparisons");
   end;

   New_Line;
   Put_Line ("A vector looks at every element in turn. An ordered set is a tree, so it");
   Put_Line ("discards half of what is left at each step -- which is what O(log N) means.");
end Show_Complexity;
