## Exercise: Aggregate Initialization

Three subprograms, and **not one loop or element assignment between them**. Each is a single
aggregate.

### The types

These are given:

```adasnippet
type Rec is record
   W : Integer := 10;
   X : Integer := 11;
   Y : Integer := 12;
   Z : Integer := 13;
end record;

type Int_Arr is array (1 .. 20) of Integer;
```

### What to write

```adasnippet
procedure Init (R : out Rec);
procedure Init_Some (A : out Int_Arr);
procedure Init (A : out Int_Arr);
```

- **`Init (R : out Rec)`** sets `X` to 100 and `Y` to 200, and leaves `W` and `Z` at their
  declared defaults — so the result is `10, 100, 200, 13`.
- **`Init_Some`** puts 99 in the first five elements and 100 in the rest.
- **`Init (A : out Int_Arr)`** puts 5 in every element.

> [!TIP]
> Each body is one assignment of one aggregate. If you find yourself writing `for I in ...`, there
> is a shortcut you have not reached for — `<>`, `others` or `..` covers all three of these.

> [!NOTE]
> Two procedures called `Init` taking different types is ordinary overloading; Ada picks by the
> argument. `Init_Some` needs its own name because it takes the same type as one of them and
> differs only in what it does.

Press **Check** when you are done.
