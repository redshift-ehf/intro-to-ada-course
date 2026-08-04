# Returning unconstrained arrays

A function may return an unconstrained array, and the caller does not have to know how long the
answer will be:

```adasnippet
function Day_Name (Day : Days) return String is
begin
   return
     (case Day is
      when Monday    => "Monday",
      when Tuesday   => "Tuesday",
      ...
      when Sunday    => "Sunday");
end Day_Name;
```

Those strings are different lengths, and that is fine — `String` is unconstrained, so the length is
part of the value rather than part of the type. Nothing is allocated on the heap to manage this and
there is nothing to free.

> [!NOTE]
> This example is here to show the mechanism. For an enumeration you would really write
> `Days'Image (Monday)`, which is built in and gives `"MONDAY"`.

## Declaring arrays from other arrays

Bounds can come from a value, as the last lesson showed:

```adasnippet
Source : constant Integer_Array := (1, 2, 3, 4);
```

or from another array:

```adasnippet
Scaled : Integer_Array (Source'Range);
```

The second form is the useful one when you are building a result that has to line up with an input.
Because the bounds are taken rather than written, the two cannot drift apart — and a loop over
`Source'Range` can index `Scaled` safely.

> [!TIP]
> This is the pattern behind most functions that transform an array: declare the result with
> `(A'Range)`, fill it in a loop over `A'Range`, return it.
