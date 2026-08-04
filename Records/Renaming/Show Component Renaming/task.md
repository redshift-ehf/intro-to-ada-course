# Renaming

Record components rename, just as subprograms and packages do:

```adasnippet
M : Months  renames Some_Day.Month;
Y : Integer renames Some_Day.Year;
```

`M` is now another name for `Some_Day.Month`. Not a copy of it — the same thing. Assign to `M` and
`Some_Day.Month` changes, because they are one component with two names.

That is what makes this worth more than saving keystrokes. A subprogram working over one record's
components can name them once at the top and then read as though it were working on plain
variables:

```adasnippet
if M = December then
   M := January;
   Y := Y + 1;
else
   M := Next (M);
end if;
```

## Subprograms too

The same declaration renames a subprogram, and an attribute counts as one:

```adasnippet
function Next (Value : Months) return Months renames Months'Succ;
```

> [!NOTE]
> A renaming is fixed at the point it is written. `Y renames Some_Day.Year` names *that* record's
> year for good — you cannot later point `Y` at a different `Date`. It is a second name for one
> thing, not a variable holding a reference to it.

Press **Run** and watch December roll over into January, taking the year with it.
