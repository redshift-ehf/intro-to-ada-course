with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Oop_Privacy is

   package P is
      --  Tagged, private and limited together: it can be extended, its components cannot be
      --  reached from outside, and it cannot be copied. Each of the three is independent of
      --  the others, and this is what a resource-owning class usually wants.
      type T is tagged limited private;

      procedure Init (A : in out T);
      procedure Bump (A : in out T);
      function Value (A : T) return Integer;

      --  A private tagged type can still be extended -- by a child package, or here, where the
      --  full view is visible.
   private
      type T is tagged limited record
         E : Integer := -1;
      end record;
   end P;

   package body P is
      procedure Init (A : in out T) is
      begin
         A.E := 0;
      end Init;

      procedure Bump (A : in out T) is
      begin
         A.E := A.E + 1;
      end Bump;

      function Value (A : T) return Integer is
      begin
         return A.E;
      end Value;
   end P;

   use P;

   T1, T2 : T;
begin
   T1.Init;
   T2.Init;

   T1.Bump;
   T1.Bump;

   Put_Line ("T1 =" & Integer'Image (T1.Value) & ", T2 =" & Integer'Image (T2.Value));

   --  T1.E := 0;
   --  ^ no: T is private, and E is not a name anyone out here has.

   --  T2 := T1;
   --  ^ no: T is limited, so there is no assignment to use.

   --  Neither restriction has anything to do with `tagged`. They apply to any type, and the
   --  Privacy chapter used both without a tag in sight.
end Show_Oop_Privacy;
