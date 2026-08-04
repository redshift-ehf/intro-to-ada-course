## Exercise: C Strings

Ada strings, handled by C's string functions.

### No C source

There is none here, and none is needed. `strlen`, `strcmp` and `toupper` are already in the C
library that every program links — importing them costs a declaration and nothing else.

```adasnippet
function Strlen (S : char_array) return size_t
  with Import, Convention => C, External_Name => "strlen";
```

### What to write

```adasnippet
function Length (S : String) return Natural;
function Compare (Left, Right : String) return Integer;
function Upper (S : String) return String;
```

- **`Length`** — what C's `strlen` reports.
- **`Compare`** — what C's `strcmp` reports: negative, zero or positive.
- **`Upper`** — the string uppercased, one character at a time through `toupper`.

The three C imports are written for you.

> [!TIP]
> **`To_C` is not optional.** An Ada `String` carries its length; a C string is terminated by a
> NUL that Ada never puts there. `Interfaces.C.To_C (S)` produces a `char_array` with the NUL
> appended. Hand `strlen` an Ada string's own storage instead and it reads past the end of it,
> which is undefined behaviour that will usually appear to work.

> [!NOTE]
> Because a C string ends at the first NUL, `Length` is **not** `S'Length`. The test passes
> `"abc" & ASCII.NUL & "def"` and expects 3 — that difference is the whole reason this exercise
> uses `strlen` rather than the obvious thing.

> [!TIP]
> `toupper` takes and returns an `int`, not a character. Go through `Character'Pos` and
> `Character'Val`.

> [!NOTE]
> This exercise is original to this course. AdaCore's *Laboratories* has no Interfacing With C
> chapter, so both of this chapter's exercises were written for it.

Press **Check** when you are done.
