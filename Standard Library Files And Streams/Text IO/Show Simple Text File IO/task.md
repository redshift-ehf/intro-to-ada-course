# Files of your own

```adasnippet
F         : File_Type;
File_Name : constant String := "simple.txt";

Create (F, Out_File, File_Name);
Put_Line (F, "Hello World #1");
Close (F);

Open (F, In_File, File_Name);
while not End_Of_File (F) loop
   Put_Line (Get_Line (F));
end loop;
Close (F);
```

`Put_Line` is the same `Put_Line` from the last lesson. All that is new is where the `File_Type`
came from.

## The three modes

| | |
|---|---|
| `Out_File` | write, truncating anything already there |
| `In_File` | read |
| `Append_File` | write past the end of an existing file |

`Create` makes a new file. `Open` requires one to exist already — and raises if it does not, which
is the next lesson.

## Reading to the end

```adasnippet
while not End_Of_File (F) loop
   Put_Line (Get_Line (F));
end loop;
```

`Get_Line` is a function here, returning a `String` of exactly the line's length. There is also a
procedure form taking a `String` and a `Last`, for when you want to avoid the allocation.

> [!TIP]
> `Delete (F)` removes an open file, and is how the examples in this chapter leave nothing behind.
> `Ada.Directories.Delete_File` does it by name, without opening anything.

> [!NOTE]
> `Create` with no name at all — `Create (F)` — makes a temporary file that is deleted when it is
> closed. Useful, and easy to miss.
