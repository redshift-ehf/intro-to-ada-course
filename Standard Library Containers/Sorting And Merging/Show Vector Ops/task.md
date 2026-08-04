# Sorting and merging

Operations on the vector as a whole, rather than on its elements.

## Concatenation

```adasnippet
V := V1 & V2 & V3;
```

The same `&` that built a vector from elements.

## Sorting

`Sort` and `Merge` are not in `Ada.Containers.Vectors`. They live in a generic **child** package,
which has to be instantiated as a child of *your instance*:

```adasnippet
package Integer_Vectors is new
  Ada.Containers.Vectors (Natural, Integer);

package Integer_Vectors_Sorting is
  new Integer_Vectors.Generic_Sorting;      --  a child of the instance

use Integer_Vectors;
use Integer_Vectors_Sorting;
```

Then:

```adasnippet
Sort (V);        --  in place
Merge (V1, V2);  --  V2's elements into V1, and V2 is left empty
```

`Merge` assumes both are already sorted. Give it unsorted input and it produces unsorted output
without complaining.

`Sort` must be O(N²) worst case and better than that on average.

> [!NOTE]
> `Generic_Sorting` is generic because sorting needs an ordering, and `Ada.Containers.Vectors`
> never asked for one — a vector of a type with no `<` is perfectly legal, it just cannot be
> sorted. The child package is where that requirement is added, to the vectors that need it.

> [!TIP]
> `Is_Sorted (V)` is in the same package and is the cheap way to assert what you think you have.
