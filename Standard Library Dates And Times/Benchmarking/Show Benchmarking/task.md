# Benchmarking

Two clock readings and a subtraction:

```adasnippet
Start_Time := Clock;

Computational_Intensive_App;

Stop_Time    := Clock;
Elapsed_Time := Stop_Time - Start_Time;

Put_Line ("Elapsed time: "
          & Duration'Image (To_Duration (Elapsed_Time))
          & " seconds");
```

`Ada.Real_Time`'s clock, for the reason the last lesson gave: a wall clock that somebody adjusts
mid-measurement gives you a wrong answer, and it will not look wrong.

## What elapsed time does not tell you

The example measures two procedures. One sleeps for half a second; the other spends half a second
doing arithmetic. Elapsed time reports them as the same:

```
waiting   took 0.501039000 seconds
computing took 0.486018000 seconds
```

They are not the same. The first used no CPU at all.

## CPU time

The distinction has its own package:

```adasnippet
with Ada.Execution_Time; use Ada.Execution_Time;

Start_Time, Stop_Time : CPU_Time;   --  not Time

Start_Time := Clock;                --  a different Clock, returning CPU_Time
...
Elapsed_Time := Stop_Time - Start_Time;
```

Same shape, different type, and the answer counts only processor time actually spent — so the
sleeping version comes out near zero and the computing version does not.

> [!NOTE]
> **`Ada.Execution_Time` will not compile on every installation.** It is part of the Real-Time
> Systems Annex, which is optional, and this course's GNAT rejects it outright:
>
> ```
> Execution_Time is not supported in this configuration
> compilation abandoned
> ```
>
> That is why the runnable example measures elapsed time only. Try the snippet above on your own
> compiler — if it builds, the CPU-time numbers are worth seeing next to the elapsed ones.

> [!TIP]
> `pragma Volatile` on the variable the loop assigns to. Without it, a compiler is entitled to
> notice that nothing reads the result and delete the work you were trying to measure.
