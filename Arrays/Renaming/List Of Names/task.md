## Exercise: List of Names

A short list of people and their ages — and the standard trick for getting a growable list out of
an array that cannot grow.

### The types

These are given:

```adasnippet
subtype Age_Type  is Natural range 0 .. 150;
subtype Name_Type is String (1 .. 20);

type Person is record
   Name : Name_Type := (others => ' ');
   Age  : Age_Type  := 0;
end record;

type People_Array is array (Positive range <>) of Person;

type People is record
   People_A   : People_Array (1 .. Max_People);
   Last_Valid : Natural := 0;
end record;
```

The array is always `Max_People` long. `Last_Valid` says how much of it means anything. Nothing is
ever deleted — the list shrinks by forgetting.

Names are a fixed twenty characters so that a `Person` is a fixed size, which is what lets an array
of them exist at all. Two functions are given for the padding: **`Padded`** turns a `String` into a
`Name_Type`, and **`Trimmed`** takes the padding back off. `Reset` is written for you as the shape
the rest follow.

### What to write

```adasnippet
procedure Add (P : in out People; Name : String);
function Get (P : People; Name : String) return Age_Type;
procedure Update (P : in out People; Name : String; Age : Age_Type);
procedure Display (P : People);
```

- **`Add`** puts a new person after the last valid one, aged 0, if there is room.
- **`Get`** returns that person's age, or 0 if there is no such person.
- **`Update`** sets an existing person's age. Somebody not on the list is not added.
- **`Display`** prints the list:

```
LIST OF NAMES:
NAME: John
AGE:  18
NAME: Patricia
AGE:  35
```

Two spaces before the age, because `'Image` brings its own.

> [!TIP]
> Compare padded names with padded names — run the incoming `Name` through `Padded` once, then
> compare. Comparing a `String` with a `Name_Type` of a different length is `False` every time, and
> that is a very quiet way for `Get` to never find anybody.

> [!NOTE]
> For `Display`, rename the valid part of the array before you loop:
>
> ```adasnippet
> Valid : People_Array renames P.People_A (1 .. P.Last_Valid);
> ```
>
> Then `Valid'Range` is exactly the people who exist, and an empty list needs no special case — the
> slice is empty and the loop runs zero times. The test checks that too.

Press **Check** when you are done.
