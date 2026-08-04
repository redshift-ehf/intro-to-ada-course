## Exercise: Colors — lookup table

The Records chapter answered "what are this colour's three channels?" with a `case` statement.
Answer it with an array instead.

### The types

These are given, and the last one is the new idea:

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

type HTML_Color_RGB is array (HTML_Color) of RGB;
```

An array indexed by the enumeration has exactly one slot per colour — not "at least eleven", not
"eleven, checked by hand". The compiler counts them, and `HTML_Color_RGB'Length` is 11 because
`HTML_Color` has eleven values.

### What to write

Fill in the table:

```adasnippet
To_RGB_Lookup_Table : constant HTML_Color_RGB := ...
```

| Colour | R | G | B | | Colour | R | G | B |
|---|---|---|---|---|---|---|---|---|
| Salmon | `FA` | `80` | `72` | | Green | `00` | `80` | `00` |
| Firebrick | `B2` | `22` | `22` | | Darkgreen | `00` | `64` | `00` |
| Red | `FF` | `00` | `00` | | Blue | `00` | `00` | `FF` |
| Darkred | `8B` | `00` | `00` | | Mediumblue | `00` | `00` | `CD` |
| Lime | `00` | `FF` | `00` | | Darkblue | `00` | `00` | `8B` |
| Forestgreen | `22` | `8B` | `22` | | | | | |

Then write `To_RGB`, which is now a single lookup rather than a case statement.

> [!TIP]
> Index the aggregate by name — `Salmon => (16#FA#, 16#80#, 16#72#),` — rather than relying on the
> order of the enumeration. It reads better, and adding a colour in the middle later cannot
> silently shift every entry.

> [!NOTE]
> Add a twelfth colour to `HTML_Color` and the table stops compiling until you give it a value.
> A `case` statement would have done the same; an `if`/`elsif` chain would not have. That is the
> argument for both.

Press **Check** when you are done.
