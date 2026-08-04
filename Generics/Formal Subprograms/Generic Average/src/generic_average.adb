function Generic_Average (A : T_Array) return Float is
   Total : Float := 0.0;
begin
   if A'Length = 0 then
      return 0.0;
   end if;

   for I in A'Range loop
      Total := Total + To_Float (A (I));
   end loop;

   return Total / Float (A'Length);
end Generic_Average;
