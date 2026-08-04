package body Online_Store is

   function Get_Status (M : Member) return String is
      pragma Unreferenced (M);
   begin
      return "Associate Member";
   end Get_Status;

   function Get_Price (M : Member; P : Amount) return Amount is
      pragma Unreferenced (M);
   begin
      return P;
   end Get_Price;

   function Get_Status (M : Full_Member) return String is
      pragma Unreferenced (M);
   begin
      return "Full Member";
   end Get_Status;

   function Get_Price (M : Full_Member; P : Amount) return Amount is
   begin
      --  Fixed times fixed is universal_fixed and has to be converted back -- the rule from
      --  Fixed-Point Types, turning up in the middle of an OOP exercise.
      return Amount (P * (1.0 - M.Discount));
   end Get_Price;

end Online_Store;
