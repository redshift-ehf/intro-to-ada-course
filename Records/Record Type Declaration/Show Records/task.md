# Record type declaration

A **record** composes several values into one. Each part is called a component, and has a name and
a type of its own:

```adasnippet
type Date is record
   Day   : Integer range 1 .. 31;
   Month : Months;
   Year  : Integer range 1 .. 3000;
end record;
```

Components look like variable declarations, and like variable declarations they may carry their own
constraints. `Day` is not merely an `Integer` — it is an `Integer` between 1 and 31, and the
compiler will hold you to it.

## Defaults

A component may also carry a default value:

```adasnippet
type Date is record
   Day   : Integer range 1 .. 31;
   Month : Months  := January;
   Year  : Integer range 1 .. 3000 := 2032;
end record;
```

Declare a `Date` without saying what is in it and `Month` and `Year` start at those values.
`Day` has no default, so it starts as nothing in particular — which is why the example sets it
before reading it.

> [!NOTE]
> A default may be any expression, including one only computable at run time. It is evaluated when
> the object is created, not when the type is declared.

Press **Run** to see both a fully specified date and one left to its defaults.
