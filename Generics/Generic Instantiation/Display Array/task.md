## Exercise: Display Array

Print any array of anything.

### The formals

```adasnippet
generic
   type T_Range is range <>;
   type T_Element is private;
   type T_Array is array (T_Range range <>) of T_Element;
   with function Image (E : T_Element) return String;
procedure Display_Array (Header : String; A : T_Array);
```

`is private` promises only assignment and equality, so there is no way to turn a `T_Element` into
text from inside. The instantiator supplies that as a formal function — which is what lets one
generic handle an `Integer` array and an array of records with no change to either.

### What to write

Print the header, then one line per element:

```
Integers
 1:  1
 2:  2
 3:  5
```

The line is the index, a colon and a space, then the element's image.

> [!TIP]
> Two spaces after the colon is not a mistake. `T_Range'Image` and `Integer'Image` each bring a
> leading space of their own, so `'Image (I) & ": " & Image (A (I))` produces exactly that.

> [!TIP]
> Loop over `A'Range`, not `1 .. A'Length`. The test instantiates it once for an array indexed
> from 1 and once for an array indexed from **0**, and only the first form works for both.

Press **Check** when you are done.
