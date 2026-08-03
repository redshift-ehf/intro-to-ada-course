function Get_State (State : Integer) return String is
begin
   case State is
      when 0      => return "Off";
      when 1      => return "On: Simple Processing";
      when 2      => return "On: Advanced Processing";
      when others => return "";
   end case;
end Get_State;
