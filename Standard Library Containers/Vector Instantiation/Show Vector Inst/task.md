# Vector instantiation

Arrays have taken you a long way. Where they run out is when the number of elements is not known
when the object is declared, and the standard library's **containers** start there.

A vector is not a type you can declare. It comes out of a generic package:

```adasnippet
with Ada.Containers.Vectors;

package Integer_Vectors is new
  Ada.Containers.Vectors
    (Index_Type   => Natural,
     Element_Type => Integer);

V : Integer_Vectors.Vector;
```

Compare that with what an array needs:

```adasnippet
A : array (1 .. 10) of Integer;   --  a size, right here, forever
```

## The two parameters

| | what it decides |
|---|---|
| `Element_Type` | what the vector holds |
| `Index_Type` | where the first element sits, and how far the indices can go |

`Natural` starts at 0, `Positive` at 1. Nothing forces either — a more restrictive range is
allowed, and the vector is then bounded by it.

**Every container in the standard library is instantiated this way.** Sets and maps later in this
chapter differ only in which parameters they ask for.

> [!NOTE]
> Two instantiations are two unrelated types, even for the same element type. That is the generics
> rule from the Generics chapter, and it is why `Integer_Vectors.Vector` and another instance's
> `Vector` will not assign to each other.

> [!TIP]
> Naming the instance for what it holds — `Integer_Vectors`, `Todo_Item_Vectors` — reads better
> than `Vectors`, because the instance is a package and you will be qualifying things with it.
