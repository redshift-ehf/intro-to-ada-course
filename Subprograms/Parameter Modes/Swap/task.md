# Parameter modes

Every parameter carries a **mode**, which says how the subprogram may use it.

| Mode | Meaning |
|---|---|
| `in` | Read-only. This is the default. |
| `out` | Written by the subprogram, read by the caller afterwards. |
| `in out` | Read and written throughout. |

```adasnippet
procedure Exchange (A, B : in out Integer) is
   Tmp : Integer;
begin
   Tmp := A;
   A   := B;
   B   := Tmp;
end Exchange;
```

## What the modes buy you

The mode is *checked*, not merely documented. Assigning to an `in` parameter does not compile. That
turns a whole class of mistake — writing to something you meant only to read — into a compile error.

`out` is how a procedure hands something back without being a function. A procedure can have
several `out` parameters, which is how you return more than one value.

> [!NOTE]
> **In other languages**
>
> Modes describe *intent*, not a passing mechanism. Ada does not say whether a parameter is passed
> by value or by reference — that is the compiler's business. You say what you mean to do with it,
> and the compiler picks a strategy that is correct for the type.

> [!TIP]
> Try adding `Value := 0;` to `Report` and pressing **Run**. The error names the mode.
