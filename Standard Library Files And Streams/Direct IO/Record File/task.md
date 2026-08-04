## Exercise: Record File

The same record type through both binary I/O packages, so the difference between them is the only
thing that varies.

> This chapter has no lab in AdaCore's *Laboratories*, so this exercise is original to this
> course. See `course-info.yaml` for which chapters carry original work.

### The package

```adasnippet
type Reading is record
   Valid : Boolean := False;
   Value : Float   := 0.0;
end record;

type Readings is array (Positive range <>) of Reading;

function Round_Trip (File_Name : String; Data : Readings) return Readings;

function Overwrite_At (File_Name : String;
                       Data      : Readings;
                       Position  : Positive;
                       Value     : Reading) return Readings;
```

Both instantiations are written for you:

```adasnippet
package Reading_Sequential_IO is new Ada.Sequential_IO (Reading);
package Reading_Direct_IO     is new Ada.Direct_IO (Reading);
```

### What to write

**`Round_Trip`** — write every reading in order, then read them all back. Sequential I/O is enough:
it goes forward, once, in each direction.

**`Overwrite_At`** — write every reading, then replace the one at `Position` **without rewriting
the others**, and return what the file then holds. This one needs direct I/O, because it has to go
back.

> [!TIP]
> `Read` is a procedure taking an `out` parameter, not a function: `Read (F, Result (I));`

> [!TIP]
> `Set_Index` counts elements from 1. `Position` is an index into `Data`, and `Data` need not start
> at 1 — the test passes an array indexed `10 .. 12` precisely to catch that. Reconciling the two
> numbering schemes is the interesting line in this exercise.

> [!NOTE]
> `Inout_File` for the second function: one `File_Type` doing both directions, so nothing has to
> be closed and reopened. Direct I/O has no `Append_File`, and with a movable index it needs none.

> [!NOTE]
> An empty `Readings` is a real case — the loop must not read past the end when there is nothing
> to read. So is a single element. The test has both.

Press **Check** when you are done.
