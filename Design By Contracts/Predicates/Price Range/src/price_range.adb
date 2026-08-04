package body Price_Range is

   function Total (Unit : Price; Count : Natural) return Price is
   begin
      return Unit * Count;
   end Total;

end Price_Range;
