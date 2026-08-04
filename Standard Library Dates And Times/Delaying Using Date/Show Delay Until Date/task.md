# Delaying using date

You saw `delay until` in the Tasking chapter. It takes an absolute `Time` — and `Ada.Calendar`
supplies one, so a program can wait until a date on a calendar.

```adasnippet
delay until Next;
```

That is the whole feature. The interest is in building `Next`.

## Two ways to say when

```adasnippet
Next : constant Time :=
  Ada.Calendar.Formatting.Time_Of
    (Year       => 2018,  Month  => 5,  Day        => 1,
     Hour       => 15,    Minute => 0,  Second     => 0,
     Sub_Second => 0.0,   Leap_Second => False,
     Time_Zone  => TZ);

Same : constant Time :=
  Ada.Calendar.Formatting.Value ("2018-05-01 15:00:00.00", TZ);
```

`Time_Of` when the components are already separate; `Value` when you have a string. They produce
the same `Time`.

## Time zones

```adasnippet
with Ada.Calendar.Time_Zones; use Ada.Calendar.Time_Zones;

TZ : constant Time_Offset := UTC_Time_Offset;
```

**Without a `Time_Zone` argument, UTC is assumed.** `UTC_Time_Offset` reads the local offset — in
minutes — and passing it makes everything you hand to `Time_Of` or `Value` local. Pass it to
`Image` too, or the output comes back in UTC and appears to disagree with the input.

## Relative instead of absolute

```adasnippet
D        : constant Duration := 0.5;
Deadline : constant Time     := Clock + D;

delay until Deadline;
```

Which is what `delay 0.5;` does, written out. The long form is the one to use in a loop that must
not drift: compute the next deadline from the last deadline, not from `Clock`.

> [!NOTE]
> The date in the example is in the past, so the program does not actually stop. A `delay until`
> whose time has gone is not an error — it returns immediately.

> [!TIP]
> `Then` is a reserved word, so it is not available as a variable name for the thing you are
> delaying to. `Deadline` reads better anyway.
