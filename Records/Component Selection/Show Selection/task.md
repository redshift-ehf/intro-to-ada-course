# Component selection

Reach a component with a dot:

```adasnippet
Put_Line (Integer'Image (D.Year));
```

The same notation writes one:

```adasnippet
Some_Day.Year := 2001;
```

There is no getter and no setter. `D.Year` *is* the component — reading it and assigning to it are
the same piece of syntax used in the two positions.

## Nesting

A record component may itself be a record, and selection follows:

```adasnippet
type Event is record
   Marker   : Character;
   Occurred : Date;
end record;

Declaration.Occurred.Year
```

Each dot moves one level in, and every step is checked. If `Occurred` were not a `Date`, or
`Date` had no `Year`, this would not compile.

Press **Run** to watch a component being read, changed, and read again.
