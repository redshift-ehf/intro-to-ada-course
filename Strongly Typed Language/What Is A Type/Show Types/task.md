# What is a type?

A **type** is a set of values together with the operations you may perform on them. In Ada you
write down the values you need, and the compiler works out how to store them.

```adasnippet
type Altitude is range 0 .. 60_000;
type Heading  is range 0 .. 359;
```

Neither declaration mentions a size. `Altitude` is not "a 32-bit integer that happens to hold
altitudes" — it is the numbers 0 to 60,000, and picking a representation wide enough for them is
the compiler's problem, not yours.

## It costs nothing

All of this is a compile-time idea. Both types above end up as ordinary machine integers, and the
finished program does no more work than it would have done without them. What the declarations buy
is that the compiler now knows an `Altitude` is not a `Heading`, and will not let one stand in for
the other — which is the subject of the rest of this chapter.

> [!NOTE]
> **Attributes come with the type**
>
> `Altitude'First` and `Altitude'Last` are the bounds, and they are available anywhere the type
> is. You never declare a separate constant for "the highest altitude" and then have to keep the
> two in step.

Press **Run** and watch both types describe themselves.
