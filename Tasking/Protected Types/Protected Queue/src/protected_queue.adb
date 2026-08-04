package body Protected_Queue is

   Capacity : constant Natural := Natural (Queue_Index'Modulus);

   protected body Queue is

      function Empty return Boolean is
      begin
         return Count = 0;
      end Empty;

      function Full return Boolean is
      begin
         return Count = Capacity;
      end Full;

      --  The barrier is what does the waiting. A task calling Push on a full queue sleeps here
      --  until a Pop makes room, and is woken by the barrier being re-evaluated when Pop ends.
      entry Push (I : Item) when Count < Capacity is
      begin
         Items (Front + Queue_Index (Count)) := I;
         Count := Count + 1;
      end Push;

      entry Pop (I : out Item) when Count > 0 is
      begin
         I := Items (Front);
         Front := Front + 1;
         Count := Count - 1;
      end Pop;

   end Queue;

end Protected_Queue;
