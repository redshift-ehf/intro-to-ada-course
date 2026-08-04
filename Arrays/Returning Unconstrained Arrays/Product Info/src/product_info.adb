package body Product_Info is

   procedure Total (P : Product_Infos; Tot : out Currency_Array) is
   begin
      --  Tot is expected to have the same bounds as P.
      for I in P'Range loop
         Tot (I) := Currency (P (I).Units) * P (I).Price;
      end loop;
   end Total;

   function Total (P : Product_Infos) return Currency_Array is
      --  Bounds taken from the argument, so the answer lines up with what was asked about.
      Result : Currency_Array (P'Range);
   begin
      for I in P'Range loop
         Result (I) := Currency (P (I).Units) * P (I).Price;
      end loop;
      return Result;
   end Total;

   function Total (P : Product_Infos) return Currency is
      Sum : Currency := 0.0;
   begin
      for I in P'Range loop
         Sum := Sum + Currency (P (I).Units) * P (I).Price;
      end loop;
      return Sum;
   end Total;

end Product_Info;
