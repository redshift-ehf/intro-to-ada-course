with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Formal_Subprograms is

   --  `with function` declares a formal *subprogram*: the instantiator supplies the operation
   --  as well as the type. This is what lets a generic do arithmetic or comparison on a type
   --  whose formal promised neither.
   generic
      Description : String;
      type T is private;
      with function Comparison (X, Y : T) return Boolean;
   procedure Check (X, Y : T);

   procedure Check (X, Y : T) is
   begin
      if Comparison (X, Y) then
         Put_Line ("Comparison (" & Description & ") between arguments is OK!");
      else
         Put_Line ("Comparison (" & Description & ") between arguments is not OK!");
      end if;
   end Check;

   --  An operator is an ordinary function and can be passed like one. Standard."=" names the
   --  predefined equality for Integer.
   procedure Check_Is_Equal is new
     Check (Description => "equality", T => Integer, Comparison => Standard."=");

   procedure Check_Is_Less is new
     Check (Description => "less than", T => Integer, Comparison => Standard."<");

   A : Integer;
   B : Integer;
begin
   A := 0;
   B := 1;

   Check_Is_Equal (A, B);
   Check_Is_Less (A, B);

   A := 1;
   Check_Is_Equal (A, B);
   Check_Is_Less (A, B);
end Show_Formal_Subprograms;
