## Exercise: Integers

One package, four ways of saying "a whole number in a range" — and the differences between them
are the whole exercise.

### The types

```adasnippet
type    I_100 is range 0 .. 100;
type    U_100 is mod 101;
type    D_50  is new I_100 range 10 .. 50;
subtype S_50  is I_100 range 10 .. 50;
```

`U_100` holds the same 101 values as `I_100` and is still a different type. `D_50` and `S_50` hold
the same 41 values as each other — and one of them is a new type while the other simply *is*
`I_100`.

### What to write

Three conversions are already written, as worked examples:

```adasnippet
function To_I_100 (V : U_100) return I_100;
function To_U_100 (V : I_100) return U_100;
function To_I_100 (V : D_50)  return I_100;
```

Yours are the two that saturate:

```adasnippet
function To_D_50 (V : I_100) return D_50;
function To_S_50 (V : I_100) return S_50;
```

Anything below 10 comes back as 10, anything above 50 comes back as 50, and anything between is
returned unchanged. Use `D_50'First` and `D_50'Last` rather than writing 10 and 50 out — then the
bounds live in one place and the code cannot drift away from the declaration.

> [!NOTE]
> Write both, then read them side by side. `To_D_50` needs `D_50 (V)` to return the in-range case,
> because `D_50` is a different type from `I_100`. `To_S_50` returns `V` just as it is, because
> `S_50` is `I_100`. Two functions that look the same and are not — which is exactly the
> distinction the lesson before this one drew.

Press **Check** when you are done.
