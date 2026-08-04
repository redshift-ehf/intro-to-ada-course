## Exercise: Numerical Exception

Two tests that go wrong in two different ways, and one handler that copes with both.

### What is given

```adasnippet
subtype Test_ID is Positive range 1 .. 2;

Custom_Exception : exception;

procedure Num_Exception_Test (ID : Test_ID);
```

`Num_Exception_Test` is written for you. Test 1 indexes past the end of an array, so
`Constraint_Error`. Test 2 raises `Custom_Exception` with a message.

### What to write

```adasnippet
procedure Check_Exception (ID : Test_ID);
```

Run the test, and report what went wrong:

| | printed |
|---|---|
| `Constraint_Error` | `Constraint_Error detected!` |
| anything else | its own message |

Nothing may escape. `Check_Exception` handles; it does not propagate.

> [!TIP]
> Two handlers. Name `Constraint_Error` specifically, and use `when E : others` for the rest —
> the `E :` is what makes `Exception_Message (E)` reachable.

> [!NOTE]
> The order matters and the compiler will not warn you. `when others` first would swallow the
> `Constraint_Error` before the specific handler ever saw it. Specific first, `others` last, is
> the rule.

Press **Check** when you are done.
