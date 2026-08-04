package body Inventory is

   function To_String (I : Item_Name) return String is
   begin
      case I is
         when Ballpoint_Pen        => return "Ballpoint Pen";
         when Oil_Based_Pen_Marker => return "Oil-based Pen Marker";
         when Feather_Quill_Pen    => return "Feather Quill Pen";
      end case;
   end To_String;

   function Init (Name : Item_Name; Quantity : Natural; Price : Float) return Item is
   begin
      --  The parameters have the same names as the components, so the named form has to say
      --  `Name => Name`. That reads oddly and is perfectly unambiguous: on the left of `=>` is
      --  always a component, on the right always an expression.
      return (Name => Name, Quantity => Quantity, Price => Price);
   end Init;

   procedure Add (Assets : in out Float; I : Item) is
   begin
      Assets := Assets + Float (I.Quantity) * I.Price;
   end Add;

end Inventory;
