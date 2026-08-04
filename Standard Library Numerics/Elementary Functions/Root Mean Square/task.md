## Exercise: Root-Mean-Square

The [root-mean-square](https://en.wikipedia.org/wiki/Root_mean_square) of a sequence: the standard
way to put a single number on the size of a signal.

### The package

```adasnippet
subtype Sig_Value is Float;

type Signal is array (Natural range <>) of Sig_Value;

function Rms (S : Signal) return Sig_Value;
```

### What to write

`Rms`. Its name is the recipe, read backwards:

1. square each value,
2. take the mean of those,
3. take the square root of that.

> [!TIP]
> Steps 1 and 2 fold into one pass — sum the squares as you go, then divide. There is no need to
> build the squared sequence.

> [!TIP]
> `S'Length` is a `Natural`, so the division needs `Sig_Value (S'Length)`.

> [!NOTE]
> **An empty signal must not divide by zero.** Return 0.0 for it. The test passes a `Signal
> (0 .. -1)`, which is a legal null array and exactly the case a straightforward implementation
> forgets.

> [!NOTE]
> `Root_Mean_Square.Signals` is written for you and generates three waveforms to measure. The
> exercise is `Rms`, not signal generation.
>
> A sine wave's RMS is its amplitude over √2 — about 0.71, which is the first thing the test
> checks, and a good sanity check on any implementation.

> [!NOTE]
> RMS is not the mean. A signal that alternates +1 and -1 has a mean of zero and an RMS of one,
> which is why it is the useful measure. The test has that case.

Press **Check** when you are done.
