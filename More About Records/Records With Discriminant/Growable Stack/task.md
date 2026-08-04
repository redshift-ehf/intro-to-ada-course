## Exercise: Growable Stack

A stack whose capacity is chosen per object.

### The type

```adasnippet
type Stack (Max_Len : Positive) is record
   Items : Items_Array (1 .. Max_Len);
   Len   : Natural := 0;
end record;
```

`Len` says how much of `Items` means anything — the same arrangement as `Last_Valid` in the Arrays
chapter's List of Names, now with the array's size chosen per object rather than fixed for all.

### What to write

```adasnippet
procedure Push (S : in out Stack; Value : Integer);
procedure Pop (S : in out Stack; Value : out Integer);
function Peek (S : Stack) return Integer;
```

- **`Push`** adds on top. A full stack is left alone — no error, no overwrite.
- **`Pop`** takes the top off and gives it back. An empty stack gives back 0 and stays empty.
- **`Peek`** returns the top without removing it, or 0 if there is none.

`Capacity`, `Is_Empty` and `Is_Full` are written for you, and the first shows how to read a
discriminant.

> [!TIP]
> Use `Is_Full` and `Is_Empty` rather than comparing `S.Len` yourself. They already say what the
> boundaries are, and a stack that overwrites its last element or reads off its bottom is exactly
> the bug this exercise is shaped to catch — the test pushes one item too many and pops one too
> few.

> [!NOTE]
> This exercise is original to this course. AdaCore's *Laboratories* has no More About Records
> chapter, so two of this chapter's three exercises were written for it rather than adapted.

Press **Check** when you are done.
