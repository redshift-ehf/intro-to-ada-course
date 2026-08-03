with Ada.Text_IO; use Ada.Text_IO;

procedure Display_State (State : Integer) is
begin
   case State is
      when 0      => Put_Line ("Off");
      when 1      => Put_Line ("On: Simple Processing");
      when 2      => Put_Line ("On: Advanced Processing");
      when others => null;
   end case;
end Display_State;
