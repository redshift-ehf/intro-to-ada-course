# Appending and prepending

```adasnippet
V.Append (20);    --  onto the end
V.Prepend (30);   --  onto the front
```

Neither is told how much room to make. That is the whole difference from an array: the vector
grows, and there is no capacity to get wrong.

## Order

```adasnippet
V.Append (20);  V.Append (10);  V.Append (0);  V.Append (13);
V.Prepend (30); V.Prepend (40); V.Prepend (100);
```

leaves `(100, 40, 30, 20, 10, 0, 13)`. Each `Prepend` pushed everything already there along by
one, so the prepended elements come out in the reverse of the order they went in.

## What it costs

The Reference Manual states worst-case complexity for both:

| | |
|---|---|
| `Append` | O(log N) |
| `Prepend` | O(N log N) |

`Prepend` is the expensive one, and the reason is in the paragraph above: everything moves. A loop
that prepends N elements is quadratic. If you find yourself writing one, append and read the
result backwards instead.

> [!NOTE]
> These are the Reference Manual's *requirements*, not a particular compiler's measurements. An
> implementation may do better; it may not do worse.
