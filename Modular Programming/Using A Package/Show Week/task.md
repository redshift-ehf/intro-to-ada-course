# Using a package

Two clauses bring a package into a file.

- **`with`** makes the package available. Without it, the name is not visible at all.
- **`use`** makes its contents visible unqualified, so you can write `Mon` rather than `Week.Mon`.

```adasnippet
with Week;

--  qualified
Put_Line (Week.Mon);

declare
   use Week;
begin
   --  unqualified, but only inside this block
   Put_Line (Sun);
end;
```

`with` is required; `use` is a convenience. A `use` inside a block lasts only as long as the block,
which is the tidiest way to have it: visible where you want it and not everywhere else.

> [!TIP]
> Press **Run**, then delete the `use Week;` line and see which reference stops compiling.
