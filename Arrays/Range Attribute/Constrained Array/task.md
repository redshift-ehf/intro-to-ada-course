## Exercise: Constrained Array

An array whose bounds are part of its type, and five operations over it.

### The types

These are given:

```adasnippet
type My_Index is range 1 .. 10;
type My_Array is array (My_Index) of Integer;
```

Every `My_Array` is ten elements long — the length is in the type, so no subprogram below has to be
told how big its argument is.

### What to write

```adasnippet
function Init return My_Array;
procedure Double (A : in out My_Array);
function First_Elem (A : My_Array) return Integer;
function Last_Elem (A : My_Array) return Integer;
function Length (A : My_Array) return Integer;
```

- `Init` returns an array counting 1 to 10.
- `Double` multiplies every element by two, in place.
- `First_Elem` and `Last_Elem` return the first and last elements.
- `Length` returns how many elements there are.

> [!TIP]
> Write all five without a single literal `1` or `10` in them. `'Range`, `'First`, `'Last` and
> `'Length` cover every one, and then changing `My_Index` to `1 .. 20` needs no other edit. That
> is the exercise — the arithmetic is not the hard part.

> [!NOTE]
> `Init` returns a `My_Array` by value, all ten elements of it, and that is ordinary in Ada.
> Nothing is allocated and nothing needs freeing.

Press **Check** when you are done.
