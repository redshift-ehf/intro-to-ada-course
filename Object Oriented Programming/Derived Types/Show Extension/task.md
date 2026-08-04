# Derived types

You have derived types before, in Strongly Typed Language. Here is what they inherit.

A subprogram is a **primitive** of a type when it is declared in the same package as the type.
That is the whole rule — there is no keyword and nothing inside the type declaration:

```adasnippet
package Week is
   type Days is (Monday, ..., Sunday);
   procedure Print_Day (D : Days);      --  a primitive of Days
end Week;
```

Derive from `Days` and `Print_Day` comes too:

```adasnippet
type Weekend_Days is new Days range Saturday .. Sunday;

--  as though this had been declared, with the same body:
--    procedure Print_Day (D : Weekend_Days);
```

## Where it stops

Two things this cannot do, and both are why the rest of the chapter exists:

- **No new components.** A derived record has exactly its parent's components.
- **No dispatching.** Which body runs is decided at compile time, from the declared type.

`tagged` is the word that lifts both.

> [!NOTE]
> "Primitive" means only "declared beside the type in a package". A subprogram taking a `Days`
> declared *outside* `Week` is an ordinary subprogram and is not inherited by anything.
