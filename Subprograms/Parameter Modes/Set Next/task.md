## Exercise: States #4

Advance the machine to its next state, wrapping round at the end.

```adasnippet
procedure Set_Next (State : in out Integer);
```

| Before | After |
|---|---|
| 0 | 1 |
| 1 | 2 |
| 2 | 0 |

`in out` because you both read the current state and write the next one.

Press **Check** when you are done.
