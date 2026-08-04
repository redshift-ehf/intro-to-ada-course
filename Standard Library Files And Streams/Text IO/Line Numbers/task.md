## Exercise: Line Numbers

Write a text file, read it back, and number what comes out.

> This chapter has no lab in AdaCore's *Laboratories*, so this exercise is original to this
> course. See `course-info.yaml` for which chapters carry original work.

### The package

```adasnippet
type Lines is array (Positive range <>) of Unbounded_String;

function Numbered (File_Name : String; Content : Lines) return String;
function Line_Count (File_Name : String) return Natural;
```

### What to write

Both bodies.

**`Numbered`** writes one line per element to `File_Name`, then reads the file back and returns
every line with its number and a colon in front:

```
1: first
2: second
3: third
```

**No newline after the last line.** `Number_Image` is written for you — `Natural'Image` brings a
leading space and this format has none.

**`Line_Count`** opens `File_Name` and counts its lines. It does not create anything, so a file
that is not there raises `Ada.Text_IO.Name_Error` — and the test expects exactly that.

> [!TIP]
> `Create (F, Out_File, …)` then `Put_Line (F, …)` then `Close (F)`, and `Open (F, In_File, …)`
> then `Get_Line (F)` until `End_Of_File (F)`.

> [!TIP]
> A separator *before* every line but the first is the shape that leaves nothing trailing. Adding
> one after each line and trimming the end afterwards works too, and is more code.

> [!NOTE]
> `Out_File` truncates, so calling `Numbered` twice must not leave the first call's lines in the
> file. The test checks it, because a `Create` accidentally written as an `Append_File` `Open`
> would otherwise pass everything else.

> [!NOTE]
> The file is left where it was written. Deleting it is the caller's business, and the test's —
> which is where cleanup belongs, not inside a function that is supposed to do one thing.

Press **Check** when you are done.
