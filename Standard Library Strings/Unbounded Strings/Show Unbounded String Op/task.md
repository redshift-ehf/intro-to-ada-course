# Building an unbounded string

The same operations as the bounded version, the same names, and nothing to say about what will not
fit:

```adasnippet
S1, S2 : Unbounded_String := Null_Unbounded_String;

S1 := S1 & "Hello";
Append (S1, " World");
S1 := S1 & " " & S2;
```

The loop that needed a `Max` to be chosen in advance now needs nothing:

```adasnippet
for I in 1 .. 12 loop
   Append (Built, Integer'Image (I * I));
end loop;
```

## It is an ordinary private type

```adasnippet
To_Unbounded_String ("abc") = To_Unbounded_String ("abc")   --  True
To_Unbounded_String ("abc") < To_Unbounded_String ("abd")   --  True
```

`Unbounded_String` has `=` and `<`, and it is definite. So it sorts, and it can be a container's
element or a map's key — which is exactly what the last exercise in this chapter does with it, and
what an `access String` could not have done without writing the comparison yourself.

> [!TIP]
> `Append (S, X)` rather than `S := S & X` in a loop. Both are correct; the first says what it
> means and gives the implementation room to grow the buffer rather than rebuild it.

> [!NOTE]
> `Unbounded_String` is controlled — it has a `Finalize` that releases the memory when the object
> goes out of scope. That is why this chapter has no counterpart to the Access Types chapter's
> warnings about freeing things.
