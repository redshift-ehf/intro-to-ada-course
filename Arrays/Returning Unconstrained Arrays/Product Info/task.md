## Exercise: Product info

Quantities and prices, totalled three different ways.

### The types

These are given:

```adasnippet
subtype Quantity is Natural;
type Currency is digits 6;

type Product is record
   Units : Quantity;
   Price : Currency;
end record;

type Product_Infos  is array (Positive range <>) of Product;
type Currency_Array is array (Positive range <>) of Currency;
```

### What to write

```adasnippet
procedure Total (P : Product_Infos; Tot : out Currency_Array);
function Total (P : Product_Infos) return Currency_Array;
function Total (P : Product_Infos) return Currency;
```

All three compute units times price. They differ in where the answer goes:

- the **procedure** writes one total per product into an array you hand it;
- the **first function** returns that array;
- the **second function** returns everything added together.

> [!NOTE]
> **Two functions, same name, same argument, different return type**
>
> Ada allows this, and resolves it by what the caller does with the result:
>
> ```adasnippet
> Each  : constant Currency_Array := Total (Items);
> Grand : constant Currency       := Total (Items);
> ```
>
> Neither call says anything the other does not — the declared type of the thing being initialised
> is what picks the function. Few languages will do this; it is the same overload resolution that
> lets two enumerations share a literal.

> [!TIP]
> Declare the array result as `Currency_Array (P'Range)` so the answer carries the input's bounds.
> The test passes an array indexed `10 .. 11` as well as one indexed `1 .. 5`, and checks that the
> result is indexed the same way.

> [!TIP]
> `Units` is a `Natural` and `Price` is a `Currency`, so multiplying them needs
> `Currency (P (I).Units)`.

Press **Check** when you are done.
