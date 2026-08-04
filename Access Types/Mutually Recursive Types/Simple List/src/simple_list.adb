package body Simple_List is

   procedure Push (L : in out List; Value : Natural) is
   begin
      --  The new node's Next is the old head, and then the new node becomes the head. Written
      --  in one line because the old head is read before Head is assigned.
      L.Head := new Node'(Content => Value, Next => L.Head);
   end Push;

   function Length (L : List) return Natural is
      Count   : Natural  := 0;
      Current : Node_Acc := L.Head;
   begin
      --  Walking a list is this loop, every time: stop at null, and step with Current.Next.
      while Current /= null loop
         Count := Count + 1;
         Current := Current.Next;
      end loop;
      return Count;
   end Length;

   function Sum (L : List) return Natural is
      Total   : Natural  := 0;
      Current : Node_Acc := L.Head;
   begin
      while Current /= null loop
         Total := Total + Current.Content;
         Current := Current.Next;
      end loop;
      return Total;
   end Sum;

   function Contains (L : List; Value : Natural) return Boolean is
      Current : Node_Acc := L.Head;
   begin
      while Current /= null loop
         if Current.Content = Value then
            return True;
         end if;
         Current := Current.Next;
      end loop;
      return False;
   end Contains;

end Simple_List;
