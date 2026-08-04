## Exercise: Versioning

A version number, readable two ways.

### The type

```adasnippet
type Version is record
   Major       : Natural;
   Minor       : Natural;
   Maintenance : Natural;
end record;
```

### What to write

```adasnippet
function Convert (V : Version) return String;
function Convert (V : Version) return Float;
```

Same name, same argument, different return type — the lesson you have just read, doing real work.

- **as a `String`**: `1.3.23`, with no spaces anywhere.
- **as a `Float`**: major and minor as one number, so `1.3.23` becomes `1.3`. Maintenance is
  dropped.

An `Image` function is given, which turns a `Natural` into text without the leading space
`'Image` insists on.

> [!TIP]
> Where the result is being assigned to something declared, the declaration picks the function:
>
> ```adasnippet
> As_Text   : constant String := Convert (V);
> As_Number : constant Float  := Convert (V);
> ```
>
> Inside an expression there is no declaration to read, so qualify it — `String'(Convert (V))`.
> The test does both.

> [!NOTE]
> `Natural'Image (3)` is `" 3"`, with a leading space, because `'Image` leaves room for a minus
> sign. That is why `Image` exists here — without it the answer comes out as `1. 3. 23`.

Press **Check** when you are done.
