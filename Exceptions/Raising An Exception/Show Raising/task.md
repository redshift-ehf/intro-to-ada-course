# Raising an exception

```adasnippet
raise My_Except;
```

Execution of the current flow is abandoned. Nothing after the `raise` in that block runs, and the
exception travels outward — through blocks, out of subprograms, up through their callers — until
something handles it. If nothing does, the program stops.

## With a message

```adasnippet
raise My_Except with "the file was not where it should have been";
```

The message travels with the occurrence and is read back with `Exception_Message`:

```adasnippet
exception
   when E : My_Except =>
      Put_Line (Exception_Message (E));
```

`when E : ...` binds the occurrence to a name. Without it you know *which kind* was raised and
nothing else about it.

## What `Ada.Exceptions` gives you

| Function | Returns |
|---|---|
| `Exception_Message (E)` | the message given with `with`, if any |
| `Exception_Name (E)` | the exception's full name, as text |
| `Exception_Information (E)` | both, plus whatever the runtime can add |

> [!NOTE]
> Raise with no message and GNAT fills in the source location — you will see `show_raising.adb:10`
> rather than an empty string. Convenient, and not something to depend on: the language does not
> say what goes there.

> [!TIP]
> Prefer a message that says what was being attempted, not what failed. "cannot open input.txt"
> tells the reader more than "file error", and the exception's own name already carries the kind.
