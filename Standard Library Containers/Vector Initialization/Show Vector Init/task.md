# Vector initialization

A vector can be given its contents in its own declaration, with `&`:

```adasnippet
use Integer_Vectors;

V : Vector := 20 & 10 & 0 & 13;
```

`use Integer_Vectors` makes the instance's types and operations directly visible, so this says
`Vector` rather than `Integer_Vectors.Vector`. Without it, every name in the chapter grows a
prefix.

## Length

```adasnippet
Put_Line ("Vector has "
          & Count_Type'Image (V.Length)
          & " elements");
```

`Length` returns **`Count_Type`**, not `Integer`. It counts elements, so it cannot be negative,
and Ada gives it a type that says so — declared in `Ada.Containers`, which is why the example
`with`s that package too.

## Dot notation, again

`Vector` is a tagged type, so `V.Length` and `Length (V)` are the same call. Everything in this
chapter is written the first way; the second is always available.

> [!NOTE]
> `&` joins vectors as well as elements, so `V & (1 & 2)` is a six-element vector. It is the same
> operator doing the same thing — a single element is treated as a vector of one.

> [!TIP]
> `Count_Type'Image` where you expect `Integer'Image` is the commonest first surprise in this
> chapter. If a comparison against an `Integer` will not compile, that is why: convert with
> `Natural (V.Length)`, or `use type Ada.Containers.Count_Type` to compare directly.
