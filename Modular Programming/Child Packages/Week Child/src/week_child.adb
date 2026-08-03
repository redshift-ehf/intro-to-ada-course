package body Week_Child is

   function First return String is
   begin
      return Week.Mon;
   end First;

   function Last return String is
   begin
      return Week.Sun;
   end Last;

end Week_Child;
