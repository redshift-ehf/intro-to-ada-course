## Exercise: List Of Unique Integers

Remove the duplicates from a collection of integers and put what is left in order.

`(7, 7, 1)` becomes `(1, 7)`.

### The package

```adasnippet
type Int_Array is array (Positive range <>) of Integer;

package Integer_Sets is new Ada.Containers.Ordered_Sets
  (Element_Type => Integer);

subtype Int_Set is Integer_Sets.Set;

function Get_Unique (A : Int_Array) return Int_Set;
function Get_Unique (A : Int_Array) return Int_Array;
```

### What to write

Both bodies.

- **The `Int_Set` version** — put every element of `A` into a set and return it. The set does both
  halves of the problem by itself: it drops the repeats, and an `Ordered_Set` is in order.
- **The `Int_Array` version** — get the set from the other `Get_Unique`, then copy it out.

> [!TIP]
> `Include`, not `Insert`. The input is expected to repeat itself, and `Insert` treats a duplicate
> as an error.

> [!TIP]
> Two functions with one name, told apart only by what they return — return-type overloading, from
> More About Types. Inside the array version, `S : constant Int_Set := Get_Unique (A);` reaches the
> other one, because `Int_Set` is what `S` is declared to be.

> [!NOTE]
> `S.Length` is a `Count_Type`, so sizing the result needs `Natural (S.Length)`.

> [!NOTE]
> `Int_Array` is unconstrained, so the bounds of what you return are yours to choose — and the
> test checks them. Start the result at 1 whatever the input was indexed from.

> [!NOTE]
> Without a set this is a nested loop and a sort. With one it is a loop and a copy, and the
> difference is the whole reason the container exists.

Press **Check** when you are done.
