## Exercise: Simple Type Extension

A tagged type and an extension of it, each with its own constructors and its own `Image`.

### The types

```adasnippet
type T_Float is tagged record
   F : Float;
end record;

type T_Mixed is new T_Float with record
   I : Integer;
end record;
```

### What to write

The three `T_Mixed` operations:

```adasnippet
overriding function Init (Value : Float) return T_Mixed;
overriding function Init (Value : Integer) return T_Mixed;
overriding function Image (Obj : T_Mixed) return String;
```

- **`Init (Float)`** — `F` is the value, `I` is it converted to an `Integer`.
- **`Init (Integer)`** — the other way round.
- **`Image`** — `{ F =>  4.00000E+00, I =>  4 }`.

The three `T_Float` versions are written for you; match their format.

> [!NOTE]
> **Why all three must be overridden.** A function *returning* the tagged type is a primitive,
> and an extension has to override every one — there is no sensible way to inherit something that
> builds a `T_Float` when a `T_Mixed` is wanted. Leave one out and the compiler says so.
>
> `Image` takes the type rather than returning it, so that one could have been inherited. It is
> overridden because the answer should mention `I`.

> [!TIP]
> Which `Init` runs is decided by the **declared type of the result** — return-type overloading
> from More About Types, now choosing between a type and its extension.

> [!TIP]
> `Float'Image` and `Integer'Image` each bring a leading space. The expected output keeps them,
> which is why there are two spaces after each `=>`.

Press **Check** when you are done.
