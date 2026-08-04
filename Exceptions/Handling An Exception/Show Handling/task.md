# Handling an exception

A handler attaches to **any** block:

```adasnippet
begin
   Open (File, In_File, "input.txt");
exception
   when Name_Error =>
      Put ("Cannot open input file");
end;
```

That includes a subprogram body — you do not need to wrap the whole thing in a nested `begin`
just to catch something.

Handlers are tried in order, and `others` catches whatever is left:

```adasnippet
exception
   when Constraint_Error => ...
   when E : others       => Put_Line (Exception_Name (E));
end;
```

## Re-raising

A bare `raise` inside a handler sends **the same occurrence** onward, message and origin intact:

```adasnippet
exception
   when E : Name_Error =>
      Put_Line ("Cannot open input file: " & Exception_Message (E));
      raise;
end;
```

That is the shape for "log it here, deal with it higher up". Naming a different exception instead
replaces it, which is the shape for "the caller should not have to know what went wrong inside".

## The one rule that catches everybody

**An exception raised in a declarative part is not caught by that block's handlers.**

```adasnippet
declare
   A : Integer := Dangerous;   --  raises
begin
   Put_Line (Integer'Image (A));
exception
   when Constraint_Error =>
      Put_Line ("never runs");
end;
```

The handler belongs to the block, and the declarations run *before* the block is properly
established. So the exception goes straight past it to whatever encloses it.

This is not a corner case. Any initialisation that can fail — a function call, a range check, an
allocation — is subject to it.

> [!TIP]
> The fix is to move the declaration inside, so it sits in a *statement* part:
>
> ```adasnippet
> begin
>    declare
>       A : Integer := Dangerous;
>    begin
>       ...
>    end;
> exception
>    when Constraint_Error => ...
> end;
> ```
>
> The Uninitialized Value test in this chapter is written that way, because it was first written
> the other way and this rule caught it.
