## Exercise: Event Manager

An event that announces itself at a time somebody else chooses.

### The type

```adasnippet
task type Manager is
   entry Start (ID : Natural);
   entry Event (At_Time : Ada.Real_Time.Time);
end Manager;
```

### What to write

The task body:

1. Accept `Start`, and remember the ID.
2. Accept `Event`, and remember the time.
3. Wait until that time.
4. Print `Event #` and the ID.

> [!TIP]
> **Wait outside the rendezvous, not inside it.** `delay until` within the `accept ... do ... end`
> would hold the caller for the whole wait, so the five managers would be set up one after another
> instead of all at once — and they would announce in call order, which is precisely what this
> exercise exists to disprove.
>
> Take the time inside the rendezvous, into a local variable. Do the waiting after `end Event;`.

> [!NOTE]
> **This is the one test in the course whose result depends on timing.** Five events are set up
> in the order 1 to 5 and are due in the order 4, 2, 5, 3, 1 — a hundred milliseconds apart. That
> separation is the whole margin, and it was chosen after measuring: thirty consecutive runs
> passed, fifteen of them with four cores deliberately saturated.
>
> AdaCore's version spaces them a second apart. This one is scaled to a tenth, so the exercise
> costs half a second rather than five.

Press **Check** when you are done.
