## Exercise: Holocene Calendar

The [Holocene calendar](https://en.wikipedia.org/wiki/Holocene_calendar) counts from the start of
the Holocene epoch rather than from year 1. For an AD year, the Holocene year is the Gregorian year
plus **10,000**.

It is a rebasing, not a different calendar: the months and the days are unchanged, and only the
year moves.

### What to write

```adasnippet
function To_Holocene_Year (T : Time) return Integer;
```

Take the year out of `T` and return its Holocene year. 2012 is 12012; 2020 is 12020.

> [!TIP]
> `Year (T)` is all you need from `Ada.Calendar` — the month, the day and the time of day play no
> part in the answer, and the test checks that they do not.

> [!NOTE]
> BC years are out of scope, which costs nothing here: `Ada.Calendar`'s `Year_Number` is
> `1901 .. 2399`, so there is no year in a `Time` that this rule does not cover. The test uses both
> ends of that range.

> [!NOTE]
> The return type is `Integer`, not `Year_Number`. It has to be — 12012 is nowhere near the
> range `Year_Number` allows, and that is the point of the exercise.

Press **Check** when you are done.
