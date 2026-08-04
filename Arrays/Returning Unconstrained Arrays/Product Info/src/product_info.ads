--  Quantities and prices, and three ways of totalling them.
package Product_Info is

   subtype Quantity is Natural;

   type Currency is digits 6;

   type Product is record
      Units : Quantity;
      Price : Currency;
   end record;

   type Product_Infos  is array (Positive range <>) of Product;
   type Currency_Array is array (Positive range <>) of Currency;

   --  The same answer three ways: written into an array you provide, returned as an array, or
   --  summed into one number.
   procedure Total (P : Product_Infos; Tot : out Currency_Array);

   function Total (P : Product_Infos) return Currency_Array;

   --  Two functions of the same name and the same argument, differing only in what they return.
   --  Ada allows that, and picks between them by what the caller does with the result.
   function Total (P : Product_Infos) return Currency;

end Product_Info;
