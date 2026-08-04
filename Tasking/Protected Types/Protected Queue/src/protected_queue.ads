--  A fixed-capacity queue that several tasks may use at once.
generic
   --  The modulus is the capacity, and it is also what makes the wrap-around arithmetic below
   --  free: adding past the end comes back to the beginning by itself.
   type Queue_Index is mod <>;

   type Item is private;
package Protected_Queue is

   type Item_Array is array (Queue_Index) of Item;

   protected type Queue is
      function Empty return Boolean;

      function Full return Boolean;

      --  Entries rather than procedures, so a full queue blocks the writer and an empty one
      --  blocks the reader instead of either failing.
      entry Push (I : Item);

      entry Pop (I : out Item);
   private
      Items : Item_Array;
      Front : Queue_Index := 0;
      Count : Natural     := 0;
   end Queue;

end Protected_Queue;
