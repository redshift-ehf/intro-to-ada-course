--  A list of prices, using the decimal fixed-point type from the last chapter.
package Price_List is

   --  Two decimal places, twelve digits.
   type Price_Type is delta 10.0 ** (-2) digits 12;

   --  Limited private, and the discriminant is still part of the public view -- a caller has to
   --  say how big a list they want even though they cannot see what is inside it.
   type Prices (Max : Positive) is limited private;

   --  A variant record: either an answer or nothing, with no room for a meaningless Price
   --  alongside Ok => False.
   type Price_Result (Ok : Boolean := False) is record
      case Ok is
         when True =>
            Price : Price_Type;
         when False =>
            null;
      end case;
   end record;

   procedure Reset (P : in out Prices);

   procedure Add (P : in out Prices; Item : Price_Type);

   function Get (P : Prices; Idx : Positive) return Price_Result;

   procedure Display (P : Prices);

   function Count (P : Prices) return Natural;

private

   type Price_Array is array (Positive range <>) of Price_Type;

   type Prices (Max : Positive) is limited record
      Items : Price_Array (1 .. Max);
      Last  : Natural := 0;
   end record;

end Price_List;
