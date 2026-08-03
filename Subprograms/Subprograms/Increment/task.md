# Subprograms

So far we have only written one kind of subprogram: the procedure. Ada has two.

- A **function** returns a value.
- A **procedure** does not.

Both are *subprograms*, and almost everything true of one is true of the other.

```adasnippet
function Increment_By
  (I    : Integer := 0;
   Incr : Integer := 1) return Integer is
begin
   return I + Incr;
end Increment_By;
```

## Calling them

Parameters can have defaults, and arguments can be given by position or by name.

```adasnippet
C := Increment_By (A, B);              --  positional
C := Increment_By (I => A, Incr => B); --  named
C := Increment_By;                     --  both defaults; no parentheses at all
```

Positional arguments must come **before** named ones. The reverse does not compile.

> [!NOTE]
> A parameterless call takes no parentheses. `Increment_By ()` is not Ada.

## Subprograms inside subprograms

A subprogram may be declared inside another, and sees everything declared around it. That is why
`Display_Result` below prints `A`, `B` and `C` without being passed any of them.

## Function results cannot be ignored

A function call is an expression, so it has to be used. Calling one as though it were a statement
is a compile error, not a warning — the same distinction between statements and expressions you met
in the first chapter.

> [!TIP]
> Press **Run** in the gutter to compile and run this file, then try turning one of the calls into
> a bare statement and see what the compiler says.
