with Ada.Containers.Ordered_Sets;

--  Duplicates out, order in -- and the set does both without being asked.
package List_Of_Unique_Integers is

   type Int_Array is array (Positive range <>) of Integer;

   package Integer_Sets is new Ada.Containers.Ordered_Sets
     (Element_Type => Integer);

   subtype Int_Set is Integer_Sets.Set;

   --  Two functions, one name, told apart by what they return.
   function Get_Unique (A : Int_Array) return Int_Set;

   function Get_Unique (A : Int_Array) return Int_Array;

end List_Of_Unique_Integers;
