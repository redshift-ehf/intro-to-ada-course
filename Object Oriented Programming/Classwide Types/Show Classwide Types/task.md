# Classwide types

A variable of type `My_Class` holds **exactly** a `My_Class`. To hold that or anything derived
from it, use the classwide type:

```adasnippet
O2 : Derived := (A => 12);
O3 : My_Class'Class := O2;   --  fine
```

`My_Class'Class` is the set of all types descending from `My_Class`, including itself. This is
where polymorphism lives in Ada: not in the type, but in `'Class`.

## What the tag buys

```adasnippet
Expanded_Name (O3'Tag)   --  "P.DERIVED"
```

`'Tag` is the runtime type information a tagged type carries and a plain record does not, and
`Ada.Tags` reads it back.

## They are indefinite

A classwide type has no fixed size — it depends what it is holding. So:

- it must be initialised where it is declared;
- it cannot be a record component;
- there is no array of `T'Class`.

That last one is a real obstacle, and Classwide Access Types is the answer to it.

> [!NOTE]
> `O3 : My_Class'Class := O2;` **copies** `O2`. It is not a reference to it — changing `O3`
> later leaves `O2` alone. For a reference you want an access type, or a parameter.
