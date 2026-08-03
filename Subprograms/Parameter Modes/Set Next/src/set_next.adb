procedure Set_Next (State : in out Integer) is
begin
   if State = 2 then
      State := 0;
   else
      State := State + 1;
   end if;
end Set_Next;
