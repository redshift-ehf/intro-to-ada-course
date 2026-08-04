## Exercise: Display Service

A task that displays whatever it is handed.

### The type

```adasnippet
task type Display_Task is
   entry Display (Text : String);
   entry Display (Value : Integer);
end Display_Task;
```

Two entries of the same name, told apart by parameter type. Entries overload exactly as
subprograms do.

### What to write

The task body. It should serve either entry, repeatedly, and stop when nobody can call it again.

```adasnippet
loop
   select
      accept ... 
   or
      accept ...
   or
      terminate;
   end select;
end loop;
```

> [!TIP]
> **Print inside the `accept ... do ... end`, not after it.** That is what makes this
> deterministic: the caller is held until the line is out, so calls in order produce lines in
> order. Print after the rendezvous instead and the output races the next call — the test runs
> the same sequence three times and expects the same answer each time.

> [!NOTE]
> `or terminate` is not optional. Without it the loop never ends, the task never finishes, and
> the master waits for it forever — the test would hang rather than fail.

> [!NOTE]
> An `Integer` prints via `Integer'Image`, which brings a leading space. The expected output
> keeps it.

Press **Check** when you are done.
