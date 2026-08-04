# Splitting on separators

There is no `Split` function. There is `Find_Token`, which is better: **what counts as a separator
is a set you choose**.

```adasnippet
with Ada.Strings.Maps; use Ada.Strings.Maps;

Whitespace : constant Character_Set := To_Set (' ');

Find_Token (Source => S,
            Set    => Whitespace,
            From   => I,
            Test   => Outside,
            First  => F,
            Last   => L);
```

- **`Set`** — the characters that separate. `To_Set` takes a character, a string of them, or a
  range.
- **`Test => Outside`** — find a run of characters *not* in the set. That is a word. `Inside`
  would find the runs of whitespace instead.
- **`First`, `Last`** — out parameters giving the range of what it found, so the token is
  `S (F .. L)`.

## The loop

```adasnippet
while I in S'Range loop
   Find_Token (S, Whitespace, I, Outside, F, L);
   exit when L = 0;

   Put_Line ("'" & S (F .. L) & "'");

   I := L + 1;
end loop;
```

`Last = 0` means nothing was found — the same "zero means no" convention as `Index`. Then carry on
from just past the token.

Widening the separator set is the only change needed to split on punctuation as well:

```adasnippet
Punctuation : constant Character_Set := To_Set (" ,.;");
```

> [!NOTE]
> `Ada.Strings.Maps` also does character *mapping* — `To_Mapping ("abc", "xyz")`, and the
> ready-made `Ada.Strings.Maps.Constants.Upper_Case_Map`. `Translate` applies one to a string,
> which is how you upper-case without a loop.

> [!TIP]
> `S (F .. L)` is a slice, from the Arrays chapter, and it costs nothing — it is not a copy unless
> you assign it to something.
