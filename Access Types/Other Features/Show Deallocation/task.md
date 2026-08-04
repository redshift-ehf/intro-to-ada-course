# Other features

Ada has manual deallocation and it has pointer arithmetic. Both are deliberately inconvenient.

## Freeing

There is no `delete` or `free` keyword. You instantiate one yourself, per access type:

```adasnippet
with Ada.Unchecked_Deallocation;

procedure Free is new Ada.Unchecked_Deallocation (Integer, Int_Acc);
```

The name is the documentation. **Unchecked** — nothing here verifies that the object is still
wanted, or that no other access value designates it. `Free` does one thing for you: it sets its
argument to `null`. Any *other* access value that pointed at the same object is now dangling, and
nothing in the language will tell you.

> [!NOTE]
> That `is new` is a generic instantiation, and generics are a later chapter. This is the one
> instantiation worth recognising early, because you will see it in any Ada code that allocates.

## Pointer arithmetic

It exists, in `System.Storage_Elements` and `System.Address_To_Access_Conversions`. Both are named
so that reaching for them is a visible decision rather than an idiom, and neither belongs in
ordinary code.

## What to do instead

Mostly: do not allocate. The alternatives are real, and every one of them is memory-safe by
construction —

- **parameter modes** where C would pass an address to write through;
- **unconstrained arrays and functions returning them** where C would allocate a buffer for the
  caller;
- **records by value**, since assignment copies and comparison compares contents;
- **the standard containers** — vectors, sets, maps — for collections that grow, which do their
  own allocation and their own freeing;
- **reference-counted smart pointers**, such as GNATCOLL's `Refcount`, for objects with genuinely
  shared ownership.

The linked list in the next lesson is the case where none of those applies: a type that refers to
itself, which is what access types are actually for.

Press **Run** to watch `Free` null its argument.
