# Ordered maps

The same program as the last lesson, with two lines changed:

```adasnippet
package Integer_Ordered_Maps is new
  Ada.Containers.Indefinite_Ordered_Maps
    (Key_Type     => String,
     Element_Type => Integer);
```

No hash, no `Equivalent_Keys`. An ordered map wants a `<` instead, and takes the predefined one
when the key type has it. Everything after the instantiation — `Include`, `Contains`, `M (K)`,
`Key (C)`, `Iterate` — is identical.

## The difference you can see

Run both. The hashed map prints its three entries in an order nobody chose; the ordered map prints
Alice, Bob, John, on every machine, every time. Ordering also gives you `First` and `Last`, which a
hashed map has no meaning for.

## Which to use

Hashed maps are generally the fastest way to associate keys with values, slightly faster than
ordered ones. **So if you do not need the ordering, use hashed.**

That said, "slightly" is doing real work in that sentence, and reproducible iteration order is
worth a lot when you are debugging or writing a test.

> [!NOTE]
> The near-identical source is the point of showing both. Swapping one container for another is
> usually a change to the instantiation and nothing else, which is what makes it reasonable to
> start with whichever is clearest and change your mind later.
