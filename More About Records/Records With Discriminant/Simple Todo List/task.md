## Exercise: Simple todo list

A to-do list whose length is chosen when it is declared, holding items of any length.

### The types

These are given, and between them they use both of the last two chapters:

```adasnippet
type Todo_Item is access String;

type Todo_Items is array (Positive range <>) of Todo_Item;

type Todo_List (Max : Positive) is record
   Items : Todo_Items (1 .. Max);
   Last  : Natural := 0;
end record;
```

The discriminant fixes how many items fit. Each item being an **access to `String`** is what lets
them be different lengths — a `String` component would have had to be one fixed width, and every
entry padded or cut to it.

### What to write

```adasnippet
procedure Add (Todos : in out Todo_List; Item : String);
procedure Display (Todos : Todo_List);
```

- **`Add`** stores the item. If the list is full it prints exactly

  ```
  ERROR: list is full!
  ```

  and adds nothing.
- **`Display`** prints `TO-DO LIST` and then one item per line, in the order they were added.

> [!TIP]
> `new String'(Item)` allocates a `String` of exactly `Item`'s length and copies it in. That single
> expression is why nothing here needs padding.

> [!NOTE]
> This exercise is adapted from AdaCore's *Laboratories*, where it appears in the More about types
> chapter. It is here instead because it needs a discriminant and an access type, and this is the
> chapter that teaches the first of those.

Press **Check** when you are done.
