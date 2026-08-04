## Exercise: Unconstrained Array

The same shape of work as the last exercise, but now the length is not part of the type.

### The type

```adasnippet
type My_Array is array (Positive range <>) of Integer;
```

Every subprogram below has to work for any length, and gets that length from the array it was
handed rather than from the type.

### What to write

```adasnippet
procedure Init (A : in out My_Array);
function Init (I, L : Positive) return My_Array;
procedure Double (A : in out My_Array);
function Diff_Prev_Elem (A : My_Array) return My_Array;
```

- **`procedure Init`** fills `A` with its own length, counting down. Five elements become
  `5, 4, 3, 2, 1`.
- **`function Init`** returns a *new* array of length `L`, counting down from `I`. So
  `Init (9, 5)` is `9, 8, 7, 6, 5`.
- **`Double`** multiplies every element by two, in place.
- **`Diff_Prev_Elem`** returns an array where each element is how much it differs from the one
  before it. The first element has nothing before it, so it comes back as 0. Given
  `1, 2, 5, 10, -10` the answer is `0, 1, 3, 5, -20`.

> [!NOTE]
> Two subprograms called `Init`, one a procedure and one a function, with different parameters.
> That is ordinary overloading — Ada picks by how you call it.

> [!TIP]
> `Diff_Prev_Elem` needs a result array to fill in. Declare it as `My_Array (A'Range)` so it takes
> its bounds from the argument. Then it works for an array that starts at 1, one that starts at 40,
> and one with a single element — and the test checks all three.

Press **Check** when you are done.
