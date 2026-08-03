## Exercise: States #2

The same three states, but *returned* rather than printed.

```adasnippet
function Get_State (State : Integer) return String;
```

| State | Result |
|---|---|
| 0 | `Off` |
| 1 | `On: Simple Processing` |
| 2 | `On: Advanced Processing` |

Returning a `String` from a function is ordinary in Ada — the length does not have to be known in
advance, and you do not have to manage any storage.

Press **Check** when you are done.
