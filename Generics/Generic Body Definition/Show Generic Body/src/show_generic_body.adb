with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Generic_Body is

   generic
      type T is private;
      Initial : T;
   package Holder is
      procedure Put_Value (Value : T);
      function Get_Value return T;
   end Holder;

   --  The body does **not** repeat `generic`, and does not repeat the formal parameters. It
   --  begins as an ordinary body and simply uses them -- T and Initial are in scope here
   --  because the specification declared them.
   package body Holder is
      Current : T := Initial;

      procedure Put_Value (Value : T) is
      begin
         Current := Value;
      end Put_Value;

      function Get_Value return T is
      begin
         return Current;
      end Get_Value;
   end Holder;

   package Int_Holder   is new Holder (T => Integer, Initial => -1);
   package Float_Holder is new Holder (T => Float,   Initial => 0.5);
begin
   --  A space of its own, because 'Image of a negative number brings no leading blank.
   Put_Line ("integer holder starts at " & Integer'Image (Int_Holder.Get_Value));
   Put_Line ("float holder starts at" & Float'Image (Float_Holder.Get_Value));

   Int_Holder.Put_Value (7);
   Put_Line ("after storing, integer holder has" & Integer'Image (Int_Holder.Get_Value));

   --  Each instance has its own Current. Instantiating a generic makes a new copy of
   --  everything in it, state included -- the two holders do not share a variable.
   Put_Line ("and the float holder is untouched at" & Float'Image (Float_Holder.Get_Value));
end Show_Generic_Body;
