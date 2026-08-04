# Text I/O

Ada has four ways to do file I/O, and this chapter is one lesson each:

| | format | random access | data types |
|---|---|---|---|
| **Text I/O** | text | | string |
| **Sequential I/O** | binary | | one type |
| **Direct I/O** | binary | yes | one type |
| **Stream I/O** | binary | yes | any number of types |

## Put_Line has always taken a file

Every `Put_Line` in this course so far has gone to standard output because that is the default,
not because it is the only choice:

```adasnippet
Put_Line (Standard_Output, "Hello World #1");
Put_Line (Standard_Error,  "Hello World #2");
Put_Line ("Hello World #3");            --  the same as the first
```

Three files are already open when a program starts: `Standard_Input`, `Standard_Output` and
`Standard_Error`. They are ordinary `File_Type` values, which is why the next lesson needs no new
procedures — only a way to get a `File_Type` of your own.

## Current_Output

```adasnippet
Put_Line (Current_Output, "Hello World #4");
```

`Current_Output` is what `Put_Line` writes to when it is not told, and it is **not a constant** —
`Set_Output` points it somewhere else.

> [!NOTE]
> That is how this course's own test harness works. `Ada_Check.Output_Of` redirects
> `Current_Output` to a file, calls your procedure, reads the file back and puts things as they
> were — which is why an exercise that simply prints can be checked at all.

> [!TIP]
> Diagnostics to `Standard_Error`, results to `Standard_Output`. It costs one parameter and it
> means a pipeline can separate them.
