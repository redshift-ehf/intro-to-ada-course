with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Exception_Declaration is
   --  An exception is an *object*, not a type. This is the whole declaration.
   My_Except : exception;

   --  Two more, and they are two distinct kinds: a handler for one does not catch the other.
   Too_Small : exception;
   Too_Large : exception;

   procedure Check (Value : Integer) is
   begin
      if Value < 0 then
         raise Too_Small;
      elsif Value > 100 then
         raise Too_Large;
      end if;
      Put_Line (Integer'Image (Value) & " is in range");
   end Check;
begin
   Check (50);

   begin
      Check (-1);
   exception
      when Too_Small => Put_Line ("caught Too_Small");
   end;

   begin
      Check (200);
   exception
      --  Only Too_Large is named here. Had Check raised Too_Small instead, this handler would
      --  not have caught it and the exception would have carried on out of the block.
      when Too_Large => Put_Line ("caught Too_Large");
   end;

   begin
      raise My_Except;
   exception
      when My_Except => Put_Line ("caught My_Except");
   end;
end Show_Exception_Declaration;
