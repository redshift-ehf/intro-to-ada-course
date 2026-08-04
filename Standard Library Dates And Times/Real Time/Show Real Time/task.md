# Real-time

`Ada.Real_Time` has a `Time` type as well, and it is **not** `Ada.Calendar.Time`. It represents a
reading of an absolute clock, with no notion of a date attached to it.

```adasnippet
with Ada.Real_Time; use Ada.Real_Time;

D    : constant Time_Span := Milliseconds (500);
Next : constant Time      := Clock + D;

delay until Next;
```

The same statement as the last lesson, against a different clock.

## Time_Span

An interval is a `Time_Span`, not a `Duration`. Four functions build one:

```adasnippet
Seconds (5)   Milliseconds (500)   Microseconds (1)   Nanoseconds (1)
```

and `To_Duration` converts back, which is what you need before printing:

```adasnippet
Put_Line (Duration'Image (To_Duration (D)));
```

`Time_Span_Unit` is the smallest interval the implementation can represent.

## Why a second clock

Two reasons, and only one of them is precision.

- **It is monotonic.** `Ada.Calendar`'s clock is the wall clock, and somebody may set it — forward,
  backward, or by an hour twice a year. A duration computed across that is wrong. `Ada.Real_Time`'s
  never goes backwards.
- **It has the granularity.** `Nanoseconds (1)` is a value you can ask for and a difference you can
  measure.

**So: `Ada.Calendar` to tell someone what time it is, `Ada.Real_Time` to measure or to schedule.**

> [!TIP]
> A cyclic task belongs on this clock, for the first reason: `Next := Next + Period; delay until
> Next;` keeps its period across a clock adjustment, and the same loop on `Ada.Calendar` does not.
