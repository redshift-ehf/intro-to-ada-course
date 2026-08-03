# Renaming

You met `renames` for subprograms. It works for packages and for individual declarations too.

```adasnippet
package IO renames Ada.Text_IO;

Start_Of_Week : String renames Week.Mon;
```

This is the middle ground between fully qualifying every reference and a blanket `use`: you name
the one thing you want, and nothing else changes visibility.

As before, nothing is copied and the original name stays available.

> [!TIP]
> Press **Run**, then add a rename for `Week.Sun` and print both ends of the week.
