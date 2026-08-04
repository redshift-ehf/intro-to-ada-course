package body Show_Child_Privacy is

   function Make (Celsius : Integer) return Reading is
   begin
      return (Celsius => Celsius);
   end Make;

   function Doubled (R : Reading) return Reading is
   begin
      return (Celsius => R.Celsius * 2);
   end Doubled;

end Show_Child_Privacy;
