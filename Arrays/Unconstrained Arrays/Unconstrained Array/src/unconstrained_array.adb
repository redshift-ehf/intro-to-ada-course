package body Unconstrained_Array is

   procedure Init (A : in out My_Array) is
      Value : Integer := A'Length;
   begin
      for I in A'Range loop
         A (I) := Value;
         Value := Value - 1;
      end loop;
   end Init;

   function Init (I, L : Positive) return My_Array is
      Result : My_Array (1 .. L);
      Value  : Integer := I;
   begin
      for K in Result'Range loop
         Result (K) := Value;
         Value := Value - 1;
      end loop;
      return Result;
   end Init;

   procedure Double (A : in out My_Array) is
   begin
      for I in A'Range loop
         A (I) := A (I) * 2;
      end loop;
   end Double;

   function Diff_Prev_Elem (A : My_Array) return My_Array is
      --  Same bounds as the argument, taken from the argument rather than assumed.
      Result : My_Array (A'Range);
   begin
      for I in A'Range loop
         if I = A'First then
            Result (I) := 0;
         else
            Result (I) := A (I) - A (I - 1);
         end if;
      end loop;
      return Result;
   end Diff_Prev_Elem;

end Unconstrained_Array;
