## Exercise: Colors

The same colours as in Strongly Typed Language, but split into their three channels instead of
being squashed into one number.

### The types

These are given:

```adasnippet
type HTML_Color is
  (Salmon, Firebrick, Red, Darkred, Lime, Forestgreen,
   Green, Darkgreen, Blue, Mediumblue, Darkblue);

subtype Int_Color is Integer range 0 .. 255;

type RGB is record
   Red   : Int_Color;
   Green : Int_Color;
   Blue  : Int_Color;
end record;
```

`Red` is both a colour name and a component name here, and that is fine: a component is only ever
reached through a dot, so `C.Red` and `Red` can never be confused with one another.

### What to write

```adasnippet
function To_RGB (C : HTML_Color) return RGB;
function Image (C : RGB) return String;
```

`To_RGB` splits each colour into its three bytes:

| Colour | R | G | B | | Colour | R | G | B |
|---|---|---|---|---|---|---|---|---|
| Salmon | `FA` | `80` | `72` | | Green | `00` | `80` | `00` |
| Firebrick | `B2` | `22` | `22` | | Darkgreen | `00` | `64` | `00` |
| Red | `FF` | `00` | `00` | | Blue | `00` | `00` | `FF` |
| Darkred | `8B` | `00` | `00` | | Mediumblue | `00` | `00` | `CD` |
| Lime | `00` | `FF` | `00` | | Darkblue | `00` | `00` | `8B` |
| Forestgreen | `22` | `8B` | `22` | | | | | |

`Image` returns the record as text, in exactly this shape:

```
(Red => 16#FA#, Green => 16#80#, Blue => 16#72#)
```

A `Hex` function is given, which turns one channel into `16#FA#` with two digits always. Use it —
that is what makes a column of these line up.

> [!NOTE]
> **Why the file is called `record_colors.adb`**
>
> The Strongly Typed Language chapter already has a `Colors`, and the whole course is one GNAT
> project — one namespace, in which two library units cannot share a name. Rather than mangle
> every task name to avoid collisions that mostly do not happen, this course qualifies the ones
> that do, with the chapter. The rule is enforced by `check_unit_names` in
> `scripts/check_course.py`, so a missed qualification fails while the author is looking at it.

Press **Check** when you are done.
