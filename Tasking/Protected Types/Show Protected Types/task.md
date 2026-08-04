# Protected types

`protected type` is to a protected object what `task type` is to a task — a template, and nothing
exists until an object of it is declared:

```adasnippet
protected type Counter is
   procedure Bump;
   function Value return Natural;
private
   Count : Natural := 0;
end Counter;

Hits   : Counter;
Misses : Counter;
```

Two counters, each with its own `Count`, each independently safe against concurrent use. Neither
knows the other exists.

## What this is for

The moment you want the *same* protection over more than one thing. One protected object guards
one piece of data; a protected type guards a kind of data, and you make as many as you need — one
per connection, one per buffer, one per device.

It combines with generics, too, which is the last step to a reusable concurrent container: a
generic package containing a protected type, instantiated for whatever element you have. That is
exactly what the exercise below is, and what `Ada.Containers`' synchronized queues are.

> [!NOTE]
> A protected type may take discriminants, like a task type and a record. A buffer whose capacity
> is chosen per object is the usual reason.

Press **Run**: two tasks hammer one counter, the other is untouched, and resetting one leaves the
other alone.
