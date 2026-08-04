--  Initialising a record and an array entirely with aggregates, and no assignment loops.
package Aggregate_Initialization is

   type Rec is record
      W : Integer := 10;
      X : Integer := 11;
      Y : Integer := 12;
      Z : Integer := 13;
   end record;

   type Int_Arr is array (1 .. 20) of Integer;

   --  Sets X and Y, and leaves W and Z at their defaults.
   procedure Init (R : out Rec);

   --  The first five elements get 99, the rest get 100.
   procedure Init_Some (A : out Int_Arr);

   --  Every element gets 5.
   procedure Init (A : out Int_Arr);

end Aggregate_Initialization;
