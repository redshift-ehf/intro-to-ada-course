## Exercise: List Of Events

A date, and everything happening on it. This is the chapter's containers and its dates together,
and it is the largest exercise in the course so far.

### Two packages

`List_Of_Events` holds the item types:

```adasnippet
type Event_Item is access String;

package Event_Item_Vectors is new Ada.Containers.Vectors
  (Index_Type => Positive, Element_Type => Event_Item);

subtype Event_Items is Event_Item_Vectors.Vector;
```

`List_Of_Events.Lists` holds the list, with the map hidden in its private part:

```adasnippet
type Event_List is tagged private;

procedure Add (Events : in out Event_List; Event_Time : Time; Event : String);
procedure Display (Events : Event_List);

private
   package Event_Time_Maps is new Ada.Containers.Ordered_Maps
     (Key_Type     => Time,
      Element_Type => Event_Items,
      "<"          => Ada.Calendar."<",
      "="          => Event_Item_Vectors."=");

   type Event_List is new Event_Time_Maps.Map with null record;
```

**A vector inside a map**: one date maps to however many events fall on it.

### What to write

Both bodies.

- **`Add`** — put `Event` on the heap and record it under `Event_Time`. A date that has no events
  yet gets its first; a date that already has some keeps them.
- **`Display`** — `EVENTS LIST`, then each date and its events:

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

Four spaces before the inner dash.

> [!TIP]
> `Date_Image` is written for you, in the body. `Image (T)` is `YYYY-MM-DD HH:MM:SS` and the first
> ten characters are the date.

> [!TIP]
> `Contains`, then `Element`, then `Include` — three map operations from the last chapter, in that
> order. `Include` rather than `Insert`, because the date may or may not already be there and
> neither case is an error.

> [!NOTE]
> **Nothing sorts anything.** The events come out oldest first because `Ordered_Maps` keeps its
> keys in order and `Iterate` walks them that way. The test adds four events out of order and
> expects them back in order, which is the only place that requirement is visible.

> [!NOTE]
> `Time` is private and its `<` lives in `Ada.Calendar`, so the instantiation has to be handed the
> operator explicitly — the `is <>` default cannot find it.

> [!NOTE]
> `Event_List` **extends** the map rather than wrapping it, which is why `Add` can call
> `Events.Contains` directly. A client sees none of those operations, because the derivation is in
> the private part — privacy and extension together, from the last two chapters.

Press **Check** when you are done.
