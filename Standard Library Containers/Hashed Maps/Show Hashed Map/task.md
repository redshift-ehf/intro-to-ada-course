# Hashed maps

A **map** associates a key with a value — a name with an age, a word with a count.

```adasnippet
package Integer_Hashed_Maps is new
  Ada.Containers.Indefinite_Hashed_Maps
    (Key_Type        => String,
     Element_Type    => Integer,
     Hash            => Ada.Strings.Hash,
     Equivalent_Keys => "=");
```

Four parameters, two of them subprograms: a hash function for the key type, and the equality that
decides when two keys are the same one. For `String`, the standard library supplies both —
`Ada.Strings.Hash` and the predefined `=`.

## Why "Indefinite"

`String` is an **indefinite** type: its size is not known from the type alone. Every container has
a definite version and an indefinite one, and a container of `String` needs the indefinite one.
`Ada.Containers.Hashed_Maps` would not take it.

## Using it

```adasnippet
M.Include ("Alice", 24);

if M.Contains ("Alice") then
   Put_Line (Integer'Image (M ("Alice")));
end if;

M ("Alice") := 25;     --  the key must already exist

for C in M.Iterate loop
   Put_Line (Key (C) & ": " & Integer'Image (M (C)));
end loop;
```

`M (K)` both reads and assigns, and raises `Constraint_Error` for a key that is not there — hence
`Contains` first. `Key (C)` and `M (C)` are the two halves of what a cursor points at.

> [!NOTE]
> **In other languages.** This is Python's `dict` and Perl's hash. The difference is that the key
> and element types are fixed at instantiation: one map, one key type, one element type. A map
> whose values are sometimes numbers and sometimes strings is not something Ada will write for
> you — declare a variant record, or two maps.

> [!TIP]
> The iteration order of a hashed map is whatever the hash produced. Do not depend on it, and do
> not test against it — the next lesson is the one to use when order matters.
