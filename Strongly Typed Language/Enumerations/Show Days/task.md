# Enumerations

An enumeration type lists its values by name:

```adasnippet
type Day is (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);
```

These are not integers with nicer spellings. `Monday` is a value of `Day` and of nothing else, and
`Day` has no arithmetic — you cannot add two days together, because that would not mean anything.

## The compiler knows every value

Which is what makes `case` over an enumeration worth having:

```adasnippet
case D is
   when Saturday | Sunday => Put_Line ("the weekend");
   when Monday .. Friday  => Put_Line ("a working day");
end case;
```

There is no `others` branch and none is needed. The compiler checks that the alternatives cover
`Day` exactly — no value missed, none listed twice.

> [!TIP]
> Delete `Saturday |` from the first alternative and press **Run**. The error names the value you
> stopped covering.

## Attributes worth knowing

| Attribute | Meaning |
|---|---|
| `Day'First`, `Day'Last` | `Monday` and `Sunday` |
| `Day'Pos (D)` | its position, counting from zero |
| `Day'Val (N)` | the value at position `N` |
| `Day'Succ (D)`, `Day'Pred (D)` | the next and previous values |
| `Day'Image (D)` | the name, as a `String` |
