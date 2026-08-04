# Formal object declaration

A generic may take **objects** as well as types:

```adasnippet
generic
   Label : String;
   type T is private;
   Slot  : in out T;
procedure Store (Value : T);
```

A formal object looks like a subprogram parameter and behaves like one, with a single difference
that changes everything about how it is used: it is fixed at **instantiation**, not passed at each
call.

```adasnippet
procedure Store_Main   is new Store (Label => "main",   T => Integer, Slot => Main);
procedure Store_Backup is new Store (Label => "backup", T => Integer, Slot => Backup);
```

Two instances of one generic, each wired to a different variable. Neither takes a destination as an
argument — the destination is part of what the instance *is*.

## The two modes

| Mode | Means |
|---|---|
| `in` (the default) | a constant for the life of the instance |
| `in out` | a variable the instance reads and writes through |

`Label : String` is the first. `Slot : in out T` is the second — and note that the instance is
writing into a variable that belongs to whoever instantiated it, which is exactly what the Generic
List exercise is built on.

> [!NOTE]
> An `in out` formal object must be given an actual that is a variable, and that variable must
> already be declared where the instantiation is written. Order matters here in a way it does not
> for types.
