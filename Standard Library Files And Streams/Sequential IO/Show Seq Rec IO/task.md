# A record, sequentially

```adasnippet
type Num_Info is record
   Valid : Boolean := False;
   Value : Float   := 0.0;
end record;

package Num_Info_IO is new Ada.Sequential_IO (Num_Info);
```

**Nothing else changes.** `Create`, `Write`, `Read`, `Close` — the same calls with a different
element type, which is the whole reason to show this twice.

Any definite type works: a record, an array with fixed bounds, an enumeration. What does not work
is a type whose size varies — `String`, or a record with a discriminant that is not fixed.

## What it cannot do

Two types in one file. The instantiation settled that, and there is no getting round it inside
`Ada.Sequential_IO`.

That limitation is the reason **Stream I/O** exists, two lessons from here.

> [!TIP]
> A variant record gets you most of the way to a mixed file while staying one type — the
> discriminant says which variant, and it is written along with everything else. Worth reaching for
> before Stream I/O, because the file stays self-describing.

> [!NOTE]
> The record's default values are part of the type, not of the file. A file written by an older
> version of your program does not acquire fields added since — it just has the wrong number of
> bytes per element, and reading it will not tell you so.
