# Building a bounded string

```adasnippet
S1 := To_Bounded_String ("Hello");
--  or: S1 := Null_Bounded_String & "Hello";

Append (S1, " World");
--  or, with truncation: Append (S1, " World", Right);

S1 := S1 & " " & S2;
```

`Null_Bounded_String` is the empty one, and the right starting point for a loop.

`&` is overloaded for every combination — bounded with bounded, bounded with `String`, bounded with
`Character` — so an expression can mix them without conversions.

## An array of them

```adasnippet
Words : constant array (1 .. 3) of Bounded_String :=
  (To_Bounded_String ("one"),
   To_Bounded_String ("two"),
   To_Bounded_String ("three"));
```

An **array of `String` is not legal** and this is: a `Bounded_String` is definite, one size
whatever it holds, so the compiler knows how big an element is. That is the same definite /
indefinite distinction that decided between `Hashed_Maps` and `Indefinite_Hashed_Maps` two chapters
ago.

> [!TIP]
> `Append` with no truncation argument raises `Length_Error` past the maximum, exactly like
> `To_Bounded_String`. In a loop that builds an unknown amount of text, that is the case to think
> about before choosing bounded over unbounded.

> [!NOTE]
> Every operation from `Ada.Strings.Fixed` has a `Bounded_String` counterpart in the instance —
> `Index`, `Count`, `Trim`, `Slice`, `Replace_Slice`. The names are the same and so are the
> arguments.
