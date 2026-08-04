# Renaming

Array elements and slices rename, just as record components do:

```adasnippet
Data : Integer_Array (1 .. 6) := (1, 2, 3, 4, 5, 6);

Middle : Integer_Array renames Data (3 .. 4);
Head   : Integer       renames Data (1);
```

`Middle` is a second name for the middle of `Data` — not a copy of it. Assign through `Middle` and
`Data` changes, because there was only ever one array.

And as the last lesson said, a slice keeps its indices, so `Middle` is indexed **3 and 4**:

```adasnippet
Middle (3) := 30;
Middle (4) := 40;
```

## What it is for

Naming the part of an array you are actually working on, once, at the top:

```adasnippet
Valid : People_Array renames List.People_A (1 .. List.Last_Valid);
```

Every line after that reads as though the array were exactly the right size, and none of them can
accidentally reach past `Last_Valid` — the renaming stops at the same place the meaning does. The
exercise below is built on precisely this.

> [!NOTE]
> A renaming is fixed where it is written. `Middle` names that slice of that array for good; you
> cannot later point it somewhere else. It is a second name for one thing, not a variable holding
> a reference to it.
