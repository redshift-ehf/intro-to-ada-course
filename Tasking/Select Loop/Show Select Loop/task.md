# Select loop

One `accept` handles one call. A task that serves many calls needs a loop — and a loop needs a
way out, or the task never ends and its master can never finish.

```adasnippet
loop
   select
      accept Reset do
         Cnt := 0;
      end Reset;
   or
      accept Increment do
         Cnt := Cnt + 1;
      end Increment;
   or
      terminate;
   end select;
end loop;
```

## `select`

Waits for whichever of the listed entries is called next, rather than fixing an order. Without
it, `accept Reset` would block until somebody called `Reset` specifically — even if `Increment`
were waiting.

## `or terminate`

The way out. It means: *if the master is finished and nobody could ever call again, stop.*

This is not a timeout and not a poll. The runtime knows when no task can still reach a call to
this one, and only then is the alternative taken. Leave it out and a server task like this one
hangs the program.

> [!TIP]
> `select` has other alternatives worth knowing about later — `or delay` for a timeout, and
> `else` for "accept only if somebody is already waiting". `or terminate` is the one you need in
> almost every server loop.

Press **Run**: main makes eight calls and then simply ends, and `T` stops on its own.
