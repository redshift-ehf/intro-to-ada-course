# When files go wrong

## Reset

```adasnippet
Create (F, Out_File, File_Name);
Put_Line (F, "Hello World #1");
Reset (F);
Put_Line (F, "Hello World #2");
Close (F);
```

The file ends up containing only the second line. `Reset` starts again at the beginning, and on an
`Out_File` that means everything written so far is gone.

## Name_Error

```adasnippet
Open (F, In_File, File_Name);   --  raises Name_Error if it is not there
```

**There is no "does this file exist" test built into `Ada.Text_IO`.** Handling the exception is
how this is done:

```adasnippet
begin
   Open (F, In_File, File_Name);
   ...
exception
   when Name_Error =>
      Put_Line ("File does not exist");
end;
```

That is not a workaround. Checking first and opening second is a race — the file can vanish
between the two — and the exception is the only answer that cannot be wrong.

## Status_Error

Operating on a file that is not open. `Delete` closes as well as removes, so anything after it on
the same `File_Type` raises this.

> [!NOTE]
> `Ada.Directories.Exists` does exist, and is fine for a question you are asking rather than a
> decision you are acting on — "is there a config file to mention in the help text" rather than
> "should I open this".

> [!TIP]
> `Use_Error` is the fourth one worth knowing: the file exists and the operation is not allowed —
> a read-only file opened `Out_File`, or a directory where a file was expected.
