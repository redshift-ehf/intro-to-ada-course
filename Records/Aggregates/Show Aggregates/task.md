# Aggregates

An **aggregate** writes a whole record value at once. There are two notations, and you can mix
them.

## Positional

The components in the order they were declared:

```adasnippet
Ada_Birthday : constant Date := (10, December, 1815);
```

Short, and it relies on the reader knowing the order.

## Named

Each value says what it is for, and the order stops mattering:

```adasnippet
Leap_Day : constant Date := (Day   => 29,
                             Month => February,
                             Year  => 2020);
```

This is the form to reach for by default. It survives someone reordering the record, and it reads
without having to look the declaration up.

## Mixing them

Allowed, so long as no positional value comes after a named one:

```adasnippet
Moon_Landing : constant Date := (20, Month => July, Year => 1969);
```

## Taking the default

An aggregate must give a value for every component — it is a whole record value, not a partial
one. When you want a component's default rather than a value of your own, `<>` says so:

```adasnippet
New_Years_Day : constant Date := (Day => 1, Month => January, Year => <>);
```

`others => <>` does the same for everything you have not already named.

> [!TIP]
> Delete `Year => <>` from that line and press **Run**. The aggregate is now incomplete, and the
> compiler says which component is missing rather than quietly filling it in.
