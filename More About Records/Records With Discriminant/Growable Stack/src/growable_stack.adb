package body Growable_Stack is

   function Capacity (S : Stack) return Natural is
   begin
      --  The discriminant is readable like any other component.
      return S.Max_Len;
   end Capacity;

   function Is_Empty (S : Stack) return Boolean is
   begin
      return S.Len = 0;
   end Is_Empty;

   function Is_Full (S : Stack) return Boolean is
   begin
      return S.Len = S.Max_Len;
   end Is_Full;

   procedure Push (S : in out Stack; Value : Integer) is
   begin
      if not Is_Full (S) then
         S.Len := S.Len + 1;
         S.Items (S.Len) := Value;
      end if;
   end Push;

   procedure Pop (S : in out Stack; Value : out Integer) is
   begin
      if Is_Empty (S) then
         Value := 0;
      else
         Value := S.Items (S.Len);
         S.Len := S.Len - 1;
      end if;
   end Pop;

   function Peek (S : Stack) return Integer is
   begin
      if Is_Empty (S) then
         return 0;
      end if;
      return S.Items (S.Len);
   end Peek;

end Growable_Stack;
