# Renaming

`renames` gives something a second name. Nothing is copied and nothing is wrapped — the new name
*is* the old one.

```adasnippet
procedure Show (Item : String) renames Ada.Text_IO.Put_Line;

function Image (Value : Integer) return String renames Integer'Image;
```

It is most useful when a name is long, awkward, or comes from somewhere you cannot change. A
rename costs nothing at run time: there is no extra call.

The original name stays visible. Renaming **adds** a name; it does not replace one.

> [!TIP]
> Press **Run**, then add a rename of your own for `Ada.Text_IO.Put` and use it.
