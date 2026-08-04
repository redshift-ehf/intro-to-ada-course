# Classwide access types

`array (1 .. 2) of T'Class` does not compile. A classwide type is indefinite, so the compiler
cannot say how big an element would be.

An access value, though, is one size whatever it designates:

```adasnippet
type T_Class is access T'Class;

Items : array (1 .. 2) of T_Class;

Items (1) := new T;
Items (2) := new T_New;
```

That is the standard way to hold a heterogeneous collection, and calls through it dispatch:

```adasnippet
for I in Items'Range loop
   Items (I).Init;   --  not overridden: reaches T's body
   Items (I).Show;   --  overridden:     reaches each element's own
end loop;
```

The loop asks nothing about what it is holding. Each element's tag answers for it.

> [!NOTE]
> `Items (I).Show` is doing two implicit things at once: dereferencing the access value, and
> dispatching on the tag of what it found. Neither needs saying — this is the same implicit
> dereference from the Access Types chapter.

> [!TIP]
> `new` means somebody has to free it, with all the caveats from Access Types. For a collection
> that owns its elements, the standard library's containers are usually the better answer;
> reach for this when the collection genuinely must be heterogeneous.
