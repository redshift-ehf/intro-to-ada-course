## Exercise: Inventory

A very small stock system: what a shop has, and what it is worth.

### The types

These are given:

```adasnippet
type Item_Name is (Ballpoint_Pen, Oil_Based_Pen_Marker, Feather_Quill_Pen);

type Item is record
   Name     : Item_Name;
   Quantity : Natural;
   Price    : Float;
end record;
```

Three components of three different types, travelling together as one value — which is what a
record is for.

### What to write

```adasnippet
function To_String (I : Item_Name) return String;
function Init (Name : Item_Name; Quantity : Natural; Price : Float) return Item;
procedure Add (Assets : in out Float; I : Item);
```

`To_String` gives the printable name:

| Value | Text |
|---|---|
| `Ballpoint_Pen` | `Ballpoint Pen` |
| `Oil_Based_Pen_Marker` | `Oil-based Pen Marker` |
| `Feather_Quill_Pen` | `Feather Quill Pen` |

`Init` builds an `Item` from its three parts.

`Add` adds one item's total value — quantity times price — to a running total. `Assets` is
`in out` because `Add` both reads it and writes it back.

> [!NOTE]
> `Init`'s parameters have the same names as the record's components, so the named aggregate reads
> `Name => Name`. That looks strange and is completely unambiguous: on the left of `=>` is always a
> component, on the right always an expression.

> [!TIP]
> `Quantity` is a `Natural` and `Price` is a `Float`, so multiplying them needs a conversion —
> `Float (I.Quantity)`. This is the Strongly Typed Language chapter arriving in ordinary work.

Press **Check** when you are done.
