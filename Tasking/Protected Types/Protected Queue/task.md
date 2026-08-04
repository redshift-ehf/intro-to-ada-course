## Exercise: Generic Protected Queue

A fixed-capacity queue that several tasks may use at once — a generic package containing a
protected type, which is where this chapter and the Generics chapter meet.

### The formals

```adasnippet
generic
   type Queue_Index is mod <>;
   type Item is private;
package Protected_Queue is

   type Item_Array is array (Queue_Index) of Item;

   protected type Queue is
      function Empty return Boolean;
      function Full return Boolean;
      entry Push (I : Item);
      entry Pop (I : out Item);
   private
      Items : Item_Array;
      Front : Queue_Index := 0;
      Count : Natural     := 0;
   end Queue;

end Protected_Queue;
```

The index is a **modular** type, and that is doing two jobs: its modulus is the capacity, and its
wrap-around is what makes a ring buffer free. `Front + Queue_Index (Count)` past the end comes
back to the beginning by itself, with no `mod` and no `if` to get wrong.

### What to write

- **`Empty`** and **`Full`** — functions, because they only read.
- **`Push`** and **`Pop`** — **entries**, because they may have to wait.

Push waits while the queue is full; Pop waits while it is empty. Both are one `when` clause.

> [!TIP]
> The barriers are the whole design. Get them right and the concurrent case needs no delays, no
> retry loop and no polling — a producer simply blocks when there is no room, and is woken when
> there is. The test moves twenty values through a queue of five with two tasks and no timing at
> all.

> [!NOTE]
> The test also empties and refills the queue so that `Front` crosses the wrap-around point. An
> index that does not wrap passes every other case and fails there.

> [!NOTE]
> A barrier may only read the protected object's own private data — so write `when Count > 0`
> rather than `when not Empty`. Calling a function from a barrier is not allowed.

Press **Check** when you are done.
