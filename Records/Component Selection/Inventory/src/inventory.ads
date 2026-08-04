--  A very small stock system: what a shop has, and what it is worth.
package Inventory is

   type Item_Name is (Ballpoint_Pen, Oil_Based_Pen_Marker, Feather_Quill_Pen);

   --  Three components of three different types -- which is the point of a record. An item's
   --  name, how many there are and what each costs travel together as one value.
   type Item is record
      Name     : Item_Name;
      Quantity : Natural;
      Price    : Float;
   end record;

   function To_String (I : Item_Name) return String;

   function Init (Name : Item_Name; Quantity : Natural; Price : Float) return Item;

   procedure Add (Assets : in out Float; I : Item);

end Inventory;
