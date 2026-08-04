# Delay

```adasnippet
delay 1.0;
--    ^ seconds
```

`delay` puts **the current task** to sleep and nobody else. Everything else carries on, which is
why the two sets of lines in the example interleave.

The value is a `Duration` — a fixed-point type counting seconds, so `delay 0.1` and
`delay 2.5` are both fine.

> [!NOTE]
> `delay` guarantees *at least* that long. It does not promise to wake you exactly then, and on
> a busy machine it will not. Two lessons on, `delay until` gives you the other guarantee.

> [!NOTE]
> AdaCore's version of this example waits a whole second each time round. This one waits a
> tenth, so it finishes while you are still looking at it. The same change is made everywhere in
> this chapter — the exercises included — and it is worth knowing that the numbers here are
> scaled rather than the ones you would use for real.

Press **Run** and watch main's single line land in the middle of the task's five.
