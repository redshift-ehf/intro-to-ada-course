# Simpler array declarations

Declaring a named index type for every array gets tiresome, so you can write the range directly:

```adasnippet
type My_Int_Array is array (1 .. 5) of My_Int;
```

This creates an anonymous subtype of `Integer` and uses that as the index. So the loop variable is
an ordinary `Integer`, and `1 .. 5` works with no conversion anywhere:

```adasnippet
for I in 1 .. 5 loop
   Put (My_Int'Image (Tab (I)));
end loop;
```

## Which to use

A named index type when the index *means* something — a `Day`, a `Sensor_Id`, a `Position` — and
mixing it up with another number would be a real mistake worth stopping.

The short form when the index is just a count, and a separate type would be ceremony without
benefit.

> [!TIP]
> The next lesson removes the `1 .. 5` from the loop entirely, which is better than either.
