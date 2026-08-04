## Exercise: Decibel Factor

Convert between a ratio and its value in decibels.

A [decibel](https://en.wikipedia.org/wiki/Decibel) expresses the ratio of two values on a
logarithmic scale. An increase of 6 dB is roughly a doubling.

### The package

```adasnippet
subtype Decibel is Float;
subtype Factor  is Float;

function To_Decibel (F : Factor) return Decibel;
function To_Factor (D : Decibel) return Factor;
```

### What to write

Both bodies:

- **`To_Decibel`** — 20 × log₁₀(F)
- **`To_Factor`** — 10^(D/20)

```
 3 dB  ->  factor 1.41         factor   2  ->   6.02 dB
 6 dB  ->  factor 2.00         factor   4  ->  12.04 dB
20 dB  ->  factor 10.00        factor 100  ->  40.00 dB
```

> [!TIP]
> `Log (F, 10.0)` — the second argument is the base. There is no `Log10`.

> [!TIP]
> `**` on floating-point values takes a `Float` exponent, so `10.0 ** (D / 20.0)` is written
> exactly as it reads.

> [!NOTE]
> The two are inverses, and the test checks that by round-tripping sixteen values through them
> both. That is what catches a 10 written for a 20 in one of them and not the other — an error
> which passes the six cases above only if you are unlucky.

> [!NOTE]
> A ratio of 1 is no change at all, which is 0 dB, and below 1 the decibels go negative. Both are
> checked, and both are places where a formula that is nearly right stops being right.

Press **Check** when you are done.
