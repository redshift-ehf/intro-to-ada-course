with Ada.Text_IO; use Ada.Text_IO;

procedure Display_On_Off (State : Integer) is

   --  Nested, because it is only ever used here -- the same nesting the chapter introduces.
   function Is_On (Value : Integer) return Boolean is
   begin
      return Value /= 0;
   end Is_On;

begin
   if Is_On (State) then
      Put_Line ("On");
   else
      Put_Line ("Off");
   end if;
end Display_On_Off;
