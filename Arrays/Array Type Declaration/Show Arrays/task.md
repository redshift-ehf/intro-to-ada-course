# Array type declaration

An array type is declared by saying what indexes it and what it holds:

```adasnippet
type Index is range 1 .. 5;
type My_Int_Array is array (Index) of My_Int;
--                          ^ the index type
--                                    ^ the element type
```

Nowhere do you write a size. The size follows from the range of the index type, which means the
bounds and the type are one decision rather than two that can disagree.

Values are written as aggregates, exactly as record values are:

```adasnippet
Arr : constant My_Int_Array := (2, 3, 5, 7, 11);
```

## Any discrete type can index

Not just integers — enumerations too, and this is often the reason to reach for an array at all:

```adasnippet
type Day is (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);
type Workload is array (Day) of Natural;

Hours : constant Workload := (Monday .. Friday => 8, Saturday | Sunday => 0);
```

`Hours (Saturday)` is now a thing you can write, and there is no way to index it with something
that is not a `Day`.

> [!NOTE]
> **Indexing looks like a call**
>
> `Arr (I)` is the same syntax as calling a function with one argument, and that is deliberate:
> from the outside, an array and a function of one argument do the same job. It means you can
> replace one with the other later without touching the callers.

> [!NOTE]
> **In other languages**
>
> An Ada array is a value, not a pointer to one. Assigning an array copies it, comparing two
> arrays compares their contents, and passing one to a subprogram passes the array — there is no
> decay to a pointer and no separate length to carry alongside it.
