# Direct I/O

`Ada.Direct_IO` is `Ada.Sequential_IO` with a position you can move. Replacing the package name is
the whole of the change for a program that only goes forwards:

```adasnippet
package Float_IO is new Ada.Direct_IO (Float);
```

## The index

```adasnippet
Set_Index (F, Index (F) - 1);
Write (F, 7.7);
```

`Index` is where the next operation will happen, **counted in elements from 1** — not in bytes.
That is what makes it usable: the element size is the compiler's business, not yours.

`Size (F)` is how many elements the file holds.

## Inout_File

```adasnippet
Create (F, Inout_File, File_Name);
```

A fourth mode, and only direct I/O has it: read and write through one `File_Type`, without closing
and reopening. Going back to the start is `Set_Index (F, 1)`.

There is **no `Append_File`** here. With an index you can move, appending is `Set_Index (F, Size (F) + 1)`.

> [!TIP]
> Fixed-size records plus direct I/O is a serviceable little database — record *n* is at index
> *n*, and updating one costs one seek and one write rather than rewriting the file. That is the
> exercise in this lesson.

> [!NOTE]
> `Index` and `Size` return `Count`, a modular-ish integer type declared in the instance. Arithmetic
> on it needs `Count` values, which is why the example's conversions are there.
