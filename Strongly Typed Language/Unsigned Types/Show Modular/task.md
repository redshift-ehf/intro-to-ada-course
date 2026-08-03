# Unsigned types

A **modular** type is declared by how many values it has, rather than by where its bounds are:

```adasnippet
type Mod_Int is mod 2 ** 5;
```

`2 ** 5` is 32, so `Mod_Int` runs from 0 to 31. Counting the values rather than naming the ends is
the natural way round for anything that is really a bit pattern.

## The arithmetic wraps

This is the difference that matters. A signed integer type raises `Constraint_Error` when a result
will not fit. A modular type wraps instead:

| Expression | Result | |
|---|---|---|
| `20 + 15` | `3` | 35, wrapped by 32 |
| `Mod_Int'First - 1` | `31` | and it wraps downwards too |

Wrapping here is a defined operation, not an accident that happens to be tolerated. That is what
these types are for — hardware registers, hashes, checksums, anywhere the arithmetic is genuinely
meant to be modular.

> [!NOTE]
> `'Modulus` is the number of values, so it is one more than `'Last`. For `Mod_Int` that is 32,
> and `Mod_Int'Last` is 31.
