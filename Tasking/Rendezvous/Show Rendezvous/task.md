# Synchronization: rendezvous

An **entry** is a point where one task agrees to meet another:

```adasnippet
task T is
   entry Start;
end T;

task body T is
begin
   accept Start;      --  wait here for somebody to call T.Start
   Put_Line ("In T");
end T;
```

`T` runs until it reaches `accept`, then waits. The caller runs until it reaches `T.Start`, then
waits. Whichever arrives first waits for the other — and that meeting is the **rendezvous**.

## Doing something while they are together

```adasnippet
accept Add (Value : Integer) do
   Total := Total + Value;
end Add;
```

The statements between `do` and `end` run while **both tasks are held**. The caller does not
continue until the block finishes, so this is how you hand data over and know it arrived.

Keep those blocks short. Everything in them is time the caller spends blocked.

> [!TIP]
> This is also how you make concurrent output deterministic. Print inside the `do ... end` and
> the caller cannot race ahead — calls in order produce lines in order, which is exactly what the
> Display Service exercise relies on.

> [!NOTE]
> An entry looks like a procedure and is not one. It belongs to a task, it can only be called
> from another task, and calling it may block for as long as that task takes to reach its
> `accept`.
