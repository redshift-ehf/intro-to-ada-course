with Ada.Calendar;

--  Two kinds of member, one price list, and a discount only one of them gets.
package Online_Store is

   type Amount is delta 10.0 ** (-2) digits 10;

   subtype Percentage is Amount range 0.0 .. 1.0;

   subtype Year_Number is Ada.Calendar.Year_Number;

   type Member is tagged record
      Start : Year_Number;
   end record;

   function Get_Status (M : Member) return String;

   function Get_Price (M : Member; P : Amount) return Amount;

   type Full_Member is new Member with record
      Discount : Percentage;
   end record;

   overriding function Get_Status (M : Full_Member) return String;

   overriding function Get_Price (M : Full_Member; P : Amount) return Amount;

end Online_Store;
