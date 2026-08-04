## Exercise: Average of Array of Any Type

The Float Average exercise again, with the restriction lifted.

### The formals

```adasnippet
generic
   type T_Range is range <>;
   type T_Element is private;
   type T_Array is array (T_Range range <>) of T_Element;
   with function To_Float (E : T_Element) return Float;
function Generic_Average (A : T_Array) return Float;
```

Compare it with the earlier one. `is digits <>` has become `is private`, so the element may now be
a record — and the body has lost every scrap of arithmetic on it. `with function To_Float` is what
puts the arithmetic back, in `Float`, where it is available.

### What to write

Weigh each element with `To_Float`, and average the results.

### Why this is worth doing twice

The test instantiates it **twice over the same record type**:

```adasnippet
function Get_Total (E : Item) return Float is (Float (E.Quantity) * E.Price);
function Get_Price (E : Item) return Float is (E.Price);

function Average_Total is new Generic_Average (..., To_Float => Get_Total);
function Average_Price is new Generic_Average (..., To_Float => Get_Price);
```

Two different questions about the same data, from one generic, with neither the generic nor the
record changed. That is the whole argument for formal subprograms in five lines.

> [!NOTE]
> An empty array still needs an answer, as before. The test passes one.

Press **Check** when you are done.
