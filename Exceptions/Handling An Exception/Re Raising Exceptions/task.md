## Exercise: Re-raising Exceptions

The same two tests, but now the handler reports and then **passes the problem on**.

### What is given

```adasnippet
Custom_Exception  : exception;
Another_Exception : exception;

procedure Num_Exception_Test (ID : Test_ID);
```

### What to write

```adasnippet
procedure Check_Exception (ID : Test_ID);
```

Report exactly as in the last exercise — then:

| Caught | Print | Then |
|---|---|---|
| `Constraint_Error` | `Constraint_Error detected!` | re-raise **it**, unchanged |
| anything else | its message | raise `Another_Exception` instead |

### The two ways onward

```adasnippet
raise;                                            --  this same occurrence, again
raise Another_Exception with "...";               --  a different one, in its place
```

A bare `raise` inside a handler keeps everything: the same kind, the same message, the same
origin. The caller sees exactly what happened.

Naming a different exception **replaces** it. The caller learns that this operation failed, and is
not handed some internal exception they have no way to interpret. That is usually the better
manners at a package boundary — and it is why the test checks that `Custom_Exception` does *not*
escape from test 2.

> [!TIP]
> The test asserts two separate things per case: what was printed, and which exception came out.
> Getting the printing right while re-raising the wrong thing passes half of it.

Press **Check** when you are done.
