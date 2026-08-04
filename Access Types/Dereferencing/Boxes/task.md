## Exercise: Boxes

An `Integer` on the heap — and the difference between changing a pointer and changing what it
points at.

### The type

```adasnippet
type Int_Box is access Integer;
```

### What to write

```adasnippet
function Make (Value : Integer) return Int_Box;
function Get (B : Int_Box) return Integer;
procedure Set (B : Int_Box; Value : Integer);
procedure Swap (A, B : Int_Box);
```

- **`Make`** allocates an `Integer` holding `Value`.
- **`Get`** returns the `Integer` the box designates.
- **`Set`** changes it.
- **`Swap`** exchanges the two `Integer`s, leaving both boxes where they are.

`Is_Empty` is written for you.

> [!TIP]
> `Set` and `Swap` both take their boxes as **`in`** parameters. That is deliberate and it
> compiles: neither changes an access value, only the `Integer` at the end of one. If you find
> yourself wanting `in out`, you are about to write the wrong thing.

> [!NOTE]
> **`Swap` is the whole exercise.** Writing
>
> ```adasnippet
> Temp := A;  A := B;  B := Temp;
> ```
>
> exchanges nothing — it swaps two local copies of the access values and leaves both `Integer`s
> exactly where they were. What you want is `A.all` and `B.all`.
>
> The test checks this by taking a second name for one of the boxes before the swap and reading
> through it afterwards. A solution that shuffles pointers passes nothing.

> [!NOTE]
> This exercise is original to this course — see the note in Text Buffer.

Press **Check** when you are done.
