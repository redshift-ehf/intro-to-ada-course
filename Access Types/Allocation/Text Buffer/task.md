## Exercise: Text Buffer

A `String` whose length is decided while the program runs.

### The type

```adasnippet
type Text is access String;
```

`String` is unconstrained, so this is the case where allocation has to settle bounds.

### What to write

```adasnippet
function Make (Size : Positive) return Text;
function Make (Content : String) return Text;
function Length (T : Text) return Natural;
procedure Fill (T : Text; C : Character);
function Value (T : Text) return String;
```

- **`Make (Size)`** allocates a buffer of that many characters, every one a space.
- **`Make (Content)`** allocates a buffer holding exactly that content.
- **`Fill`** overwrites every character.
- **`Value`** returns the characters.

`Length` is written for you, and shows the pattern the others need.

### Null is a value, not a mistake

Every operation here has to have an answer for `null`, because `null` is an ordinary value of
`Text` and a caller may pass one:

| | on a null buffer |
|---|---|
| `Length` | 0 |
| `Value` | `""` |
| `Fill` | does nothing |

Dereferencing `null` raises `Constraint_Error`. Checking for it is not defensive clutter — it is
the difference between a package that composes and one that only works when you are careful.

> [!TIP]
> `Fill` takes its buffer as an **`in`** parameter and still changes it. That is not a loophole:
> the access value is what may not change, and `T.all` is not the access value. This is the
> distinction the next lesson is entirely about.

> [!NOTE]
> This exercise is original to this course. AdaCore's *Laboratories* has no Access Types chapter,
> so this chapter's three exercises were written for it rather than adapted.

Press **Check** when you are done.
