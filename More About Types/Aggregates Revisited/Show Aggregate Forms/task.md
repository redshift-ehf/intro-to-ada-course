# Aggregates: a primer

You have been using aggregates since the Records chapter. This is the rest of the notation, and
the rule behind it.

## The rule

**Every component must be given a value — including ones that have a default.** So this is
rejected:

```adasnippet
type Point is record
   X, Y : Integer := 0;
end record;

Origin : Point := (X => 0);   --  Y is missing
```

The default applies when you declare a `Point` and say nothing about it. An aggregate is a
complete value, so it has to be complete.

## The four shortcuts

That rule would be tiresome without these:

| Notation | Means |
|---|---|
| `<>` | this component's own default |
| `\|` | several components sharing one value |
| `others` | everything not named yet |
| `..` | a run of array indices |

```adasnippet
Origin   : Point := (X | Y => <>);
Origin_2 : Point := (others => <>);

Points_2 : Point_Array := (1       => (1, 2),
                           2       => (3, 4),
                           3 .. 20 => <>);
```

That last one also shows something from the Arrays chapter: the aggregate's own index values gave
`Points_2` its bounds, so it runs 1 to 20 without anyone writing a constraint.

## One ordering rule

Positional values may come before named ones, never after:

```adasnippet
(20, Month => July, Year => 1969)   --  fine
(Month => July, 20, Year => 1969)   --  not
```

Once you start naming, keep naming — otherwise "the next one" would have no clear meaning.

> [!TIP]
> `others => <>` is the one to remember. It means "and everything else as declared", and it is how
> you write an aggregate that survives someone adding a component later.
