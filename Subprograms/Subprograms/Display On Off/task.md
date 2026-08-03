## Exercise: States #3

Write a procedure that prints whether the machine is on, using a **nested** function to decide.

```adasnippet
function Is_On (Value : Integer) return Boolean;   --  declare this inside Display_On_Off
procedure Display_On_Off (State : Integer);
```

State 0 is off; states 1 and 2 are both on.

| State | Output |
|---|---|
| 0 | `Off` |
| 1 | `On` |
| 2 | `On` |

Declare `Is_On` in `Display_On_Off`'s declarative part — between `is` and `begin` — and call it from
the body. That is the nesting the chapter introduced.

Press **Check** when you are done.
