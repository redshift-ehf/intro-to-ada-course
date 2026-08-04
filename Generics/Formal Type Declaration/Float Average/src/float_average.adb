function Float_Average (A : T_Array) return T_Element is
   Total : T_Element := 0.0;
begin
   --  An empty array has no average, and dividing by its length would raise. Nought is the
   --  answer this one gives; the point is that it gives one.
   if A'Length = 0 then
      return 0.0;
   end if;

   for I in A'Range loop
      Total := Total + A (I);
   end loop;

   return Total / T_Element (A'Length);
end Float_Average;
