## Exercise: Colors

Write a package that turns HTML colour names into the hexadecimal codes behind them.

### The types

```adasnippet
type HTML_Color is
  (Salmon, Firebrick, Red, Darkred, Lime, Forestgreen,
   Green, Darkgreen, Blue, Mediumblue, Darkblue);

type Basic_HTML_Color is (Red, Green, Blue);
```

Read those two again: `Red`, `Green` and `Blue` appear in both. That is legal, and deliberate. An
enumeration literal behaves like a function returning its own type, and functions overload — so
`Red` names two different values of two different types, and where both could apply the context
decides which is meant.

### What to write

```adasnippet
function To_Integer (C : HTML_Color) return Integer;
function To_HTML_Color (C : Basic_HTML_Color) return HTML_Color;
```

`To_Integer` returns the colour's hexadecimal code. Ada writes hexadecimal as `16#FA8072#` — the
base, then the digits between hashes.

| Colour | Code | Colour | Code |
|---|---|---|---|
| Salmon | `16#FA8072#` | Green | `16#008000#` |
| Firebrick | `16#B22222#` | Darkgreen | `16#006400#` |
| Red | `16#FF0000#` | Blue | `16#0000FF#` |
| Darkred | `16#8B0000#` | Mediumblue | `16#0000CD#` |
| Lime | `16#00FF00#` | Darkblue | `16#00008B#` |
| Forestgreen | `16#228B22#` | | |

`To_HTML_Color` maps each basic colour to the `HTML_Color` of the same name.

> [!NOTE]
> In `To_HTML_Color` you will end up writing `when Red => return Red;`, where the two `Red`s are
> different values of different types. Nothing has to be written to tell them apart: the case
> selector settles the one on the left and the return type settles the one on the right.

Press **Check** when you are done.
