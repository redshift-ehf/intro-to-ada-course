## Exercise: Average of Array of Float

Average an array of any floating-point type.

### The formals

```adasnippet
generic
   type T_Range is range <>;
   type T_Element is digits <>;
   type T_Array is array (T_Range range <>) of T_Element;
function Float_Average (A : T_Array) return T_Element;
```

Three formals for what feels like one idea, and all three are needed. Knowing the element type
does not tell the compiler how the array is indexed, and knowing both does not give it the array
type — so the array type is a formal too, written in terms of the other two.

`is digits <>` is what earns the body its arithmetic. With `is private` there would be no `+`,
no `/`, and no way to average anything.

### What to write

The sum of the elements over how many there are.

> [!TIP]
> `A'Length` is a universal integer and the total is a `T_Element`. Dividing one by the other
> needs `T_Element (A'Length)` — the Strongly Typed Language chapter, still applying.

> [!NOTE]
> **An empty array has no average.** Dividing by `A'Length` would raise `Constraint_Error`, so
> decide what to return and return it — this exercise says nought. The test passes an empty
> array, and a solution that only works on non-empty ones fails there rather than in front of
> somebody later.

Press **Check** when you are done.
