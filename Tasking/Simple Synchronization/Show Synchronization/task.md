# Simple synchronization

A master waits for its subtasks. That is the first synchronisation, and it costs nothing to use:

```adasnippet
procedure Show_Simple_Sync is
   task T;
   task body T is
   begin
      for I in 1 .. 10 loop
         Put_Line ("hello");
      end loop;
   end T;
begin
   null;
   --  will wait here until T has terminated
end Show_Simple_Sync;
```

The procedure has nothing left to do, and still cannot return until `T` has finished. A construct
containing subtasks completes its own statements, then waits.

The same applies to a task declared in a **package**: the main subprogram synchronises with it
before the program ends, wherever it was declared.

> [!NOTE]
> **In other languages**
>
> There is no `join` here, and nothing to forget to call. A scope that started tasks does not
> leave until they are done, so a task cannot outlive the thing that created it and there is no
> such thing as a leaked one.

> [!TIP]
> This is enough on its own more often than you would think. If all you need is "do these three
> things at once and carry on when they are all finished", declaring three tasks in a block is
> the entire program.
