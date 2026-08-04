# Inserting elements

You have three ways to add to a vector already: `&` at the declaration, `Append`, and `Prepend`.
`Insert` is for a position in the middle.

```adasnippet
C := V.Find (10);
if C /= No_Element then
   V.Insert (C, 9);
end if;
```

**`Insert` puts the element *before* the cursor**, which is why it takes a cursor rather than a
value. `(20, 10, 12)` becomes `(20, 9, 10, 12)`.

## The shape of it

Find, check, insert. The check is not decoration — `Insert` at `No_Element` raises
`Constraint_Error`, and `Find` returns `No_Element` whenever the value is not there. Every
operation in this chapter that takes a cursor has the same requirement.

> [!NOTE]
> There is no "insert after". To put something at the end, `Append`; anywhere else, find the
> element you want to be *after* and insert before its successor — or think in terms of the gap
> rather than the element, which is what a cursor position really names.

> [!TIP]
> `Insert` also has forms taking a count and a position rather than a cursor. They are worth
> looking up when you need them; the cursor form is the one that composes with `Find`.
