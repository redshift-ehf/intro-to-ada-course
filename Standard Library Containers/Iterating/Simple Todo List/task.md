## Exercise: Simple Todo List (Vectors)

You have written this before. In More About Records it was a discriminant, an array and a `Last`;
here it is a vector, and the point of doing it twice is what falls away.

### The package

```adasnippet
type Todo_Item is access String;

package Todo_Item_Vectors is new Ada.Containers.Vectors
  (Index_Type   => Natural,
   Element_Type => Todo_Item);

subtype Todo_List is Todo_Item_Vectors.Vector;
```

No `Max`. No `Items`. No `Last`. The vector keeps all three, and there is no longer a "list is
full" case to report.

### What to write

Both bodies:

- **`Add`** — put the item in the list. `Todo_Item` is an access type, so the `String` has to be
  allocated: `new String'(Item)`.
- **`Display`** — `TO-DO LIST` on the first line, then one item per line.

> [!TIP]
> `Todos.Append (new String'(Item));` is the whole of `Add`. Compare it with the array version,
> which had to check `Last` against `Max`, print an error, and give up.

> [!TIP]
> `for I of Todos loop` gives you a `Todo_Item` — an access value. `I.all` is the `String` it
> designates.

> [!NOTE]
> The instantiation is given rather than asked for because there is one way to write it and you
> have just seen it twice. The work here is in the body.

> [!NOTE]
> Each item is allocated to its own length, so nothing is padded or cut — `"Buy milk"` and
> `"Schedule dentist appointment"` sit in the same list and both come out whole. The test checks
> exactly that, along with a second list staying independent of the first.

Press **Check** when you are done.
