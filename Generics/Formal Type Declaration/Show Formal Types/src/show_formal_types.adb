with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Formal_Types is

   --  `is private` promises the least: assignment and equality, and nothing else. So the body
   --  may copy a T and compare two, and may not add them.
   generic
      type T is private;
   function Same (A, B : T) return Boolean;

   function Same (A, B : T) return Boolean is
   begin
      return A = B;
   end Same;

   --  `is private` also promises a *definite* type -- one whose size is known, so the body may
   --  declare a variable of it. String is not definite, and `new Same (T => String)` is
   --  rejected with "actual for T must be a definite subtype".
   --
   --  `(<>)` in front drops that promise. Now String is allowed, and in exchange the body may
   --  no longer declare an uninitialised T.
   generic
      type T (<>) is private;
   function Same_Any (A, B : T) return Boolean;

   function Same_Any (A, B : T) return Boolean is
   begin
      return A = B;
   end Same_Any;

   --  `is (<>)` means any discrete type -- integer or enumeration. Discrete types have 'First,
   --  'Last, 'Succ, and can index a loop, so the body may use all of that.
   generic
      type T is (<>);
   function Count_Of return Natural;

   function Count_Of return Natural is
      Total : Natural := 0;
   begin
      for Value in T loop
         pragma Unreferenced (Value);
         Total := Total + 1;
      end loop;
      return Total;
   end Count_Of;

   --  `is digits <>` means any floating-point type, so the body gets the arithmetic.
   generic
      type T is digits <>;
   function Midpoint (A, B : T) return T;

   function Midpoint (A, B : T) return T is
   begin
      return (A + B) / 2.0;
   end Midpoint;

   type Day is (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);

   function Same_Integer is new Same (T => Integer);
   function Same_String is new Same_Any (T => String);
   function How_Many_Days is new Count_Of (T => Day);
   function Middle is new Midpoint (T => Float);
begin
   Put_Line ("two equal integers: " & Boolean'Image (Same_Integer (3, 3)));
   Put_Line ("two equal strings: " & Boolean'Image (Same_String ("ada", "ada")));
   Put_Line ("days in a week:" & Natural'Image (How_Many_Days));
   Put_Line ("midway between 1.0 and 2.0:" & Float'Image (Middle (1.0, 2.0)));

   --  The rule is that the body may only use what the formal promises. Widen the promise and
   --  more instantiations become possible; narrow it and the body can do more.
end Show_Formal_Types;
