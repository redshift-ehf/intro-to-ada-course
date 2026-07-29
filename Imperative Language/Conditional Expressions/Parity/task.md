## Conditional expressions

An `if` **statement** does something. An `if` **expression** *is* something — it has a value, so it
can go wherever a value can.

```adasnippet
S : constant String :=
  (if N > 0 then " is a positive number" else " is not a positive number");
```

That is one declaration with one initial value, rather than a variable declared empty and then
assigned in two branches. It also lets `S` be `constant`, which the two-branch version cannot: you
can see at a glance that nothing later changes it.

Being an expression, it can go straight into a call:

```adasnippet
Put_Line (if I mod 2 = 0 then "even" else "odd");
```

`case` has the same treatment, with commas between the alternatives rather than semicolons, because
it is one expression and not a sequence of statements:

```adasnippet
(case I is
    when 1      => "the first",
    when 2      => "the second",
    when others => "further along")
```

Three rules to know:

- Every branch must produce the same type. `(if X then 1 else "one")` is not a value of any type,
  and the compiler says so.
- The parentheses are required, unless the expression already sits inside some — which is why
  `Put_Line (if …)` above needs none of its own.
- `else` is mandatory, except when the branches are Boolean, where a missing one means `True`.

The same coverage rule as before applies to a `case` expression: every value accounted for, so
`others` unless you have genuinely listed them all.

Press **Run**.
