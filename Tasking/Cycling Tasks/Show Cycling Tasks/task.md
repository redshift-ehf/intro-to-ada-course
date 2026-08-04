# Cycling tasks

`delay 0.1` waits a tenth of a second **starting now**. So in a loop that also does work, the work
is added to the wait every time round, and the cycles drift further apart:

```
drifting -- delay 0.1 each time round:
  cycle 1 at 0.154 s
  cycle 2 at 0.308 s
  cycle 3 at 0.460 s
```

A tenth of a second of waiting plus a twentieth of work gives a cycle of about 155 ms, not 100 —
and the error accumulates.

## `delay until`

Names the **moment** to wake up rather than a duration to wait:

```adasnippet
Next := Clock + Cycle;
loop
   delay until Next;
   Busy;
   Next := Next + Cycle;
end loop;
```

Now the work happens *inside* the interval instead of being added to it:

```
steady -- delay until a fixed schedule:
  cycle 1 at 0.613 s
  cycle 2 at 0.713 s
  cycle 3 at 0.814 s
```

A hundred milliseconds apart, and staying that way however long `Busy` takes — up to the point
where it takes longer than the cycle, which no scheme can rescue.

> [!NOTE]
> `Ada.Real_Time` is the package to use for this. Its `Clock` is monotonic — it does not jump
> when the system clock is adjusted — which `Ada.Calendar`'s does not promise. For anything that
> must happen at regular intervals, `Ada.Real_Time` is the right one.

> [!TIP]
> Compute `Next` from the *previous* `Next`, never from `Clock`. Re-reading the clock each time
> round quietly reintroduces the drift you were trying to remove.
