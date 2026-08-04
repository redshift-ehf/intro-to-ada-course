# Indexing

Two checks apply to every index, and they happen at different times.

## The index type, at compile time

The index is type-checked like any other value. Two index types with identical ranges are still
two types:

```adasnippet
type My_Index   is range 1 .. 5;
type Your_Index is range 1 .. 5;

type My_Int_Array is array (My_Index) of My_Int;

Tab : My_Int_Array := (2, 3, 5, 7, 11);

for I in Your_Index loop
   Put (My_Int'Image (Tab (I)));   --  does not compile
end loop;
```

`Tab` is indexed by `My_Index` and by nothing else. This is the Strongly Typed Language chapter
again: identical ranges do not make identical types, and the whole point is that an index into one
array cannot wander into another.

## The bounds, at run time

Going outside the bounds raises `Constraint_Error`:

```adasnippet
for I in Index range 2 .. 6 loop
   Put (My_Int'Image (Tab (I)));   --  raises when I is 6
end loop;
```

The array stops at 5, so reading element 6 is an error — and it is reported as one, at the moment
it happens, rather than returning whatever occupied the next few bytes.

> [!NOTE]
> **In other languages**
>
> This is the check C does not do. There, reading one past the end is not an error but a silent
> read of unrelated memory, which is where a large share of security vulnerabilities begin. Ada
> checks by default; the check can be turned off where it has been proven unnecessary, which is a
> different thing from never having been there.
