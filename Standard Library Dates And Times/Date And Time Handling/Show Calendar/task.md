# Date and time handling

The standard library takes two approaches to time, and the difference is not precision but
*purpose*:

| | for |
|---|---|
| `Ada.Calendar` | dates and times — what day is it, when is the meeting |
| `Ada.Real_Time` | absolute clock and time spans — how long did that take, wake me in 5ms |

Both declare a type called `Time`, and they are **different types**. This lesson and the next are
`Ada.Calendar`; the two after them are `Ada.Real_Time`.

## Reading the clock

```adasnippet
with Ada.Calendar;            use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;

Now : constant Time := Clock;

Put_Line ("Current time: " & Image (Now));
```

`Image` is in the child package `Ada.Calendar.Formatting`, and gives `YYYY-MM-DD HH:MM:SS`.

## Taking it apart, and putting it together

```adasnippet
Split (Now, Now_Year, Now_Month, Now_Day, Now_Seconds);

Fixed : constant Time := Ada.Calendar.Time_Of (2018, 5, 1);
```

`Split` uses **out parameters** rather than returning a record — four things come back, and
`Year_Number`, `Month_Number`, `Day_Number` and `Day_Duration` are four different types.

Those types are real subtypes with real ranges: `Month_Number` is `1 .. 12`, so `Time_Of (2018,
13, 1)` does not compile, and a *computed* 13 raises `Constraint_Error` rather than quietly rolling
into next year. There is a whole class of date bug that Ada declines to have.

## Arithmetic

```adasnippet
Tomorrow : constant Time     := Now + 86_400.0;
Gap      : constant Duration := Tomorrow - Now;
```

`Time` plus `Duration` is a `Time`; `Time` minus `Time` is a `Duration`. `Time` is ordered, so
`>` and `<` work.

> [!NOTE]
> Both `Ada.Calendar` and `Ada.Calendar.Formatting` declare a `Time_Of` and a `Year`, with
> different profiles. `use` both and those calls become ambiguous, which is why the example
> qualifies two of them. That is not a flaw — `Formatting`'s versions take an hour, a minute and a
> time zone, and are a different operation.

> [!TIP]
> `Year_Number` is `1901 .. 2399`. Dates outside that range are not `Ada.Calendar`'s problem, and
> if you need them you want a different library.
