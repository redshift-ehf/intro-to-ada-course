## Exercise: Generic list

A list of anything — and the one exercise where formal **objects** do the work.

### The formals

```adasnippet
generic
   type Item is private;
   type Items is array (Positive range <>) of Item;
   Name       : String;
   List_Array : in out Items;
   Last       : in out Natural;
   with procedure Put (I : Item);
package Generic_List is
   procedure Init;
   procedure Add (I : Item; Status : out Boolean);
   procedure Display;
end Generic_List;
```

Look at `List_Array` and `Last`. They are `in out` formal **objects**, so the storage does not
belong to the package at all — it belongs to whoever instantiated it, and the instance writes
straight through into their variables. That is an unusual design and a deliberate one here: it is
the clearest possible demonstration of what an `in out` formal object means.

### What to write

```adasnippet
procedure Add (I : Item; Status : out Boolean);
procedure Display;
```

- **`Add`** appends if there is room, and sets `Status` to say whether there was. A full list is
  left exactly as it was.
- **`Display`** prints `Name`, then one line per item using the formal `Put`.

`Init` is written for you.

> [!TIP]
> `List_Array'First` is not necessarily 1 — the formal array type is indexed by `Positive range
> <>`, so the actual could start anywhere. Index with `List_Array'First + Last - 1` rather than
> `Last`.

> [!NOTE]
> **Do not write `use Ada.Text_IO` in the body.** This generic has a formal called `Put`, and a
> `use` clause would make `Ada.Text_IO.Put` visible under the same name — every unqualified call
> then becomes ambiguous. Name the standard package instead: `Ada.Text_IO.New_Line`.

> [!TIP]
> The test checks the instantiator's own `Numbers` and `Count` after using the list, which only
> works because the instance was writing through to them all along.

Press **Check** when you are done.
