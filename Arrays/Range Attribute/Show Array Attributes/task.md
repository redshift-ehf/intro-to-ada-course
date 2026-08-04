# Range attribute

An array knows its own bounds, so nothing else has to:

```adasnippet
for I in Tab'Range loop
   Put (My_Int'Image (Tab (I)));
end loop;
```

`Tab'Range` is the index range of `Tab`. Change the array's declaration and this loop follows,
which the previous lesson's `for I in 1 .. 5` would not have.

## The others

| Attribute | Meaning |
|---|---|
| `Tab'Range` | the whole index range |
| `Tab'First` | the first index |
| `Tab'Last` | the last index |
| `Tab'Length` | how many elements |

`'First` and `'Last` when you want part of the range:

```adasnippet
for I in Tab'First .. Tab'Last - 1 loop   --  everything but the last
```

## Null arrays

An index range whose upper bound is below its lower bound is legal, and describes an array with no
elements at all. `Tab'Length` is then 0, and a `for` loop over `Tab'Range` runs zero times — which
is exactly what you want, and is why loops written this way need no special case for "empty".

> [!NOTE]
> Prefer `'Range` and `'Length` to any number you wrote yourself. The attribute cannot disagree
> with the array; a literal can, and will, the first time somebody changes the declaration.
