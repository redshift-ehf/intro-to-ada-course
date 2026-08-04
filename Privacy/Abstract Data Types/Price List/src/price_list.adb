with Ada.Text_IO; use Ada.Text_IO;

package body Price_List is

   procedure Reset (P : in out Prices) is
   begin
      P.Last := 0;
   end Reset;

   procedure Add (P : in out Prices; Item : Price_Type) is
   begin
      if P.Last < P.Max then
         P.Last := P.Last + 1;
         P.Items (P.Last) := Item;
      end if;
   end Add;

   function Get (P : Prices; Idx : Positive) return Price_Result is
   begin
      if Idx <= P.Last then
         return (Ok => True, Price => P.Items (Idx));
      else
         --  No Price component exists in this one, so there is nothing to invent.
         return (Ok => False);
      end if;
   end Get;

   procedure Display (P : Prices) is
   begin
      Put_Line ("PRICE LIST");
      for I in 1 .. P.Last loop
         Put_Line (Price_Type'Image (P.Items (I)));
      end loop;
   end Display;

   function Count (P : Prices) return Natural is
   begin
      return P.Last;
   end Count;

end Price_List;
