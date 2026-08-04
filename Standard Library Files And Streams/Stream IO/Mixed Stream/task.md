## Exercise: Mixed Stream

Two types in one file, one of them of a length the file has to record for itself.

> This chapter has no lab in AdaCore's *Laboratories*, so this exercise is original to this
> course. See `course-info.yaml` for which chapters carry original work.

### The package

```adasnippet
type Labels is array (Positive range <>) of Unbounded_String;
type Values is array (Positive range <>) of Float;

function Round_Trip (File_Name : String;
                     L         : Labels;
                     V         : Values) return String;
```

### What to write

The body. Write each label and then its value into one stream file, read the file back, and return
one line per pair:

```
first = 1.50000E+00
second = 2.40000E+00
```

**No newline after the last line.**

> [!TIP]
> `String'Output` for the labels, not `String'Write`. They are different lengths, so the bounds
> have to go into the file too — `'Write` would put the characters and nothing else, and nothing
> could read them back. `Float` is definite, so `'Write` is enough for the value, as long as the
> reader uses `'Read` to match.

> [!TIP]
> `String'Input` is a function returning a `String` of the right size. `Float'Read` is a procedure
> taking an `out` parameter. That asymmetry is the whole `'Input` / `'Read` distinction, showing up
> in two adjacent lines.

> [!NOTE]
> **The file records nothing about what is in it.** Read the two types back in the order they were
> written or the result is nonsense, with no exception to tell you. Keeping the write and the read
> next to each other, as one loop each, is what makes that order checkable.

> [!NOTE]
> `L` and `V` are the same length but need not have the same bounds — the test passes `5 .. 6` and
> `9 .. 10` together. Walk them by offset.

> [!NOTE]
> One of the test's labels contains a newline, and comes back whole. Nothing about `'Output`
> depends on the characters — the length in the file is what ends the string.

Press **Check** when you are done.
