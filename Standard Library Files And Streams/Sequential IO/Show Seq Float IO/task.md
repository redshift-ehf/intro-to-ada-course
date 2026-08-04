# Sequential I/O

Binary rather than text, and **one type per file**:

```adasnippet
with Ada.Sequential_IO;

package Float_IO is new Ada.Sequential_IO (Float);
use Float_IO;

F : Float_IO.File_Type;
```

`Ada.Sequential_IO` is generic, so the element type is chosen at instantiation, and the file can
hold nothing else. That restriction is what buys you the simplicity: no formatting, no parsing, no
ambiguity about where one value ends.

## The same vocabulary

`Create`, `Open`, `Close`, `Reset`, `Delete` and `End_Of_File` are exactly as they were for text.
Two things change:

```adasnippet
Write (F, 1.5);      --  instead of Put_Line
Read (F, Value);     --  instead of Get_Line
```

## Read is a procedure

```adasnippet
declare
   Value : Float;
begin
   Read (F, Value);
```

Not `Value := Read (F);`. The element type may be anything at all, including a limited type that
cannot be returned from a function — so `Read` takes it as an `out` parameter instead. Every one of
these packages does the same.

> [!NOTE]
> `File_Type` here is `Float_IO.File_Type`, not `Ada.Text_IO.File_Type`. They are different types
> from different packages, and a program using both — like the example — has to say which.

> [!TIP]
> The file is not portable. It is whatever `Float` looks like in memory on the machine that wrote
> it, with that machine's size and byte order. Fine for a scratch file; not a format to publish.
