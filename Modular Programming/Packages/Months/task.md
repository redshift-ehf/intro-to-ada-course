## Exercise: Months

Complete a package that names the twelve months and can list them.

The specification is already written for you — twelve constants and one procedure:

```adasnippet
package Months is
   Jan : constant String := "January";
   --  ...
   Dec : constant String := "December";

   procedure Display_Months;
end Months;
```

Your job is the **body**. `Display_Months` prints a heading and then every month in order:

```
Months:
- January
- February
- March
...
- December
```

Each month on its own line, prefixed with `- `. The tests check the constants and the whole listing,
so the text has to match exactly.

> [!TIP]
> The constants are declared in the spec, so the body can use `Jan` directly — no qualification and
> no `use` needed. A package body already sees its own spec.

Press **Check** when you are done.
