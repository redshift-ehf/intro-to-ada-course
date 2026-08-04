with Ada.Command_Line;
with Ada_Check;
with Generic_Average;

procedure Test_Generic_Average is

   type Index is range 1 .. 100;

   type Item is record
      Quantity : Natural;
      Price    : Float;
   end record;

   type Item_Array is array (Index range <>) of Item;

   --  Two different ways to weigh the same element, so two instances of one generic over one
   --  type. Neither the generic nor the record had to change to get a second answer.
   function Get_Total (E : Item) return Float is (Float (E.Quantity) * E.Price);
   function Get_Price (E : Item) return Float is (E.Price);

   function Average_Total is new Generic_Average
     (T_Range => Index, T_Element => Item, T_Array => Item_Array, To_Float => Get_Total);

   function Average_Price is new Generic_Average
     (T_Range => Index, T_Element => Item, T_Array => Item_Array, To_Float => Get_Price);

   Basket : constant Item_Array :=
     ((Quantity => 10, Price =>  5.0),
      (Quantity => 20, Price =>  7.5),
      (Quantity => 30, Price => 10.0),
      (Quantity => 40, Price =>  2.5));

   Empty : constant Item_Array (1 .. 0) := (others => (0, 0.0));
begin
   Ada_Check.Suite ("Average of Array of Any Type");

   --  50 + 150 + 300 + 100 = 600, over four items.
   Ada_Check.Equal ("average value per item", Average_Total (Basket), 150.0);

   --  5.0 + 7.5 + 10.0 + 2.5 = 25.0, over four items.
   Ada_Check.Equal ("average price", Average_Price (Basket), 6.25);

   Ada_Check.Equal ("one item, by value", Average_Total ((1 => (3, 4.0))), 12.0);
   Ada_Check.Equal ("one item, by price", Average_Price ((1 => (3, 4.0))), 4.0);

   Ada_Check.Equal ("an empty basket by value", Average_Total (Empty), 0.0);
   Ada_Check.Equal ("an empty basket by price", Average_Price (Empty), 0.0);

   --  A quantity of nought contributes nothing to the total and still counts toward the price.
   declare
      With_Zero : constant Item_Array :=
        ((Quantity => 0, Price => 8.0), (Quantity => 2, Price => 2.0));
   begin
      Ada_Check.Equal ("nought of one, two of another, by value",
                       Average_Total (With_Zero), 2.0);
      Ada_Check.Equal ("and by price", Average_Price (With_Zero), 5.0);
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Generic_Average;
