## Exercise: List Of Events (Unbounded Strings)

The list of events from Dates & Times, with the descriptions held as `Unbounded_String` instead of
`access String`.

Everything else is already written. The map, the vector, `Add`'s structure, `Display`'s loops,
`Date_Image` — untouched. **The exercise is the size of the change**, and that is what it is for.

### What to write

Three things, in two files.

**In `strings_list_of_events.ads`** — the item type:

```adasnippet
subtype Event_Item is ...;
```

It has to hold a description of any length, and it has to be **definite**, because it is a
vector's `Element_Type`. What you are given is `String (1 .. 8)`, which is definite and plainly
not long enough.

**In `strings_list_of_events-lists.adb`** — the two lines that touch a description:

- in `Add`, turn the `String` parameter into an `Event_Item` and append it;
- in `Display`, turn an `Event_Item` back into a `String` to print it.

### The output, unchanged

```
EVENTS LIST
- 2018-01-01
    - New Year's Day
- 2018-02-16
    - Final check
    - Release
- 2018-12-03
    - Brother's birthday
```

> [!TIP]
> `To_Unbounded_String` and `To_String` are the two directions.

> [!NOTE]
> Compare what disappears. The old version wrote `new String'(Event)` and `I.all` — an allocation
> and a dereference, and an owner somewhere responsible for freeing it. This one has neither:
> `Unbounded_String` is a value, it is controlled, and it releases its own memory.

> [!NOTE]
> `Ada.Strings.Unbounded` is not `with`ed in the body. The parent spec `with`s and `use`s it, and a
> child inherits both — a small thing from Modular Programming that this exercise happens to
> demonstrate.

Press **Check** when you are done.
