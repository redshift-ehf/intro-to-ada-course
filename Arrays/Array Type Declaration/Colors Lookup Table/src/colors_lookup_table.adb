package body Colors_Lookup_Table is

   function To_RGB (C : HTML_Color) return RGB is
   begin
      return To_RGB_Lookup_Table (C);
   end To_RGB;

end Colors_Lookup_Table;
