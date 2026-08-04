## Exercise: Primary Color

Picking one channel out of an HTML colour — where "one channel" is itself a type.

### The types

```adasnippet
type HTML_Color is
  (Salmon, Firebrick, Red, Darkred, Lime, Forestgreen,
   Green, Darkgreen, Blue, Mediumblue, Darkblue);

subtype HTML_RGB_Color is HTML_Color
  with Static_Predicate => ... ;

function To_Int_Color (C : HTML_Color; S : HTML_RGB_Color) return Int_Color;
```

### What to write

The predicate: `HTML_RGB_Color` is `Red`, `Green` or `Blue` and nothing else.

Those three are scattered through the enumeration — positions 3, 7 and 9 — so a range constraint
cannot express this. A static predicate can.

> [!TIP]
> The form is a membership test: `HTML_RGB_Color in Red | Green | Blue`. Naming the subtype
> itself is how a predicate refers to the value being checked.

> [!NOTE]
> `To_Int_Color` is written with `if`/`elsif`. With the predicate in place a `case` over `S`
> would be exhaustive with three alternatives and no `others` — which is neater, and would stop
> compiling the moment the predicate were wrong. It is written the long way here precisely so
> that a missing predicate produces a *failing test* rather than a compile error, and you can
> see what it was buying.

Press **Check** when you are done.
