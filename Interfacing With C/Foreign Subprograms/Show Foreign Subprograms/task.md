# Foreign subprograms

## Ada calling C

```adasnippet
function Fs_Twice (A : int) return int
  with Import, Convention => C;
```

`Import` says the body is elsewhere; `Convention => C` says how to call it. If the Ada name
matches the C one, that is all.

When it should not — and it usually should not, since C library names are rarely what you would
have chosen — name it explicitly:

```adasnippet
function Clamp (Value, Low, High : int) return int
  with Import, Convention => C, External_Name => "fs_clamp";
```

## C calling Ada

The mirror image, with `Export`:

```adasnippet
package C_API is
   function My_Func (A : int) return int
     with Export, Convention => C, External_Name => "my_func";
end C_API;
```

and from C, an ordinary extern:

```c
extern int my_func (int a);

int v = my_func (2);
```

Nothing on the C side says the function is Ada.

> [!NOTE]
> **An exported subprogram must be at library level.** This lesson's example imports but does not
> export, because its subprograms are nested inside a procedure and GNAT refuses: *"local
> subprogram cannot be exported"*. A nested subprogram may need access to its enclosing frame,
> and there is no way to hand that to C.
>
> Put anything you mean to export in a package. The **C Statistics** exercise does, and is
> tested doing a full round trip: Ada calls C, which calls back into Ada.
