# Bounded strings

A bounded string has a maximum length, like a `String` — and is **not an array**, unlike a
`String`. The second half is what makes it assignable at run time.

```adasnippet
package B_Str is new
  Ada.Strings.Bounded.Generic_Bounded_Length (Max => 15);
use B_Str;

S1, S2 : Bounded_String;

S1 := To_Bounded_String ("Hello");
S2 := To_Bounded_String ("Hello World");
```

Two different lengths into the same declared type, and no padding anywhere.

## Length, not 'Length

```adasnippet
Length (S)     --  the current length
Max_Length     --  the maximum, from the instantiation
```

`S'Length` **does not compile**. `Bounded_String` is not an array, so it has no `'Length` — which
is the same fact as everything else on this page, showing up as a compile error rather than as a
subtlety.

## Too long

```adasnippet
S1 := To_Bounded_String ("Something longer to say here...");
--  raises Ada.Strings.Length_Error

S1 := To_Bounded_String ("Something longer to say here...", Right);
--  keeps the first 15 characters
```

The truncation argument is the same `Right` / `Left` / `Error` from `Ada.Strings.Fixed`, and the
default is to raise.

> [!NOTE]
> The maximum is set at **instantiation**, not per object — so every `Bounded_String` from `B_Str`
> has the same `Max_Length`, and two instantiations with different maxima are two unrelated types.

> [!TIP]
> With GNAT, a bounded string is on the stack and an unbounded one is on the heap. That is the
> practical reason to reach for bounded: a known ceiling and no allocation.
