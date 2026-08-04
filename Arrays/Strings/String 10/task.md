## Exercise: String_10

Fit any `String` into exactly ten characters.

### The type

```adasnippet
subtype Ten_Chars is String (1 .. 10);
```

A constrained `String` subtype — still a `String`, with its bounds pinned down. Because it is a
subtype and not a new type, a `Ten_Chars` can be passed anywhere a `String` is wanted.

### What to write

```adasnippet
function To_String_10 (S : String) return Ten_Chars;
```

- Longer than ten: keep the first ten characters.
- Shorter than ten: keep all of it and pad the rest with spaces.
- Exactly ten: unchanged.

So `"And this is a long string"` becomes `"And this i"`, and `"Hey!"` becomes `"Hey!      "`.

> [!TIP]
> **Do not assume `S` starts at index 1.** A `String` that arrived as a slice starts wherever the
> slice started — `Text (10 .. 25)` has `'First` of 10. Use `S'First` and `S'Length` rather than
> `1` and `S'Last`, and the test that passes a slice will pass too.

> [!NOTE]
> Start the result as `(others => ' ')` and copy into the front of it. Then the padding case needs
> no code of its own — it is what happens when you copy fewer than ten characters.

Press **Check** when you are done.
