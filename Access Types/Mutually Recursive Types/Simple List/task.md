## Exercise: Simple List

A singly linked list — the data structure access types exist for.

### The types

These are given:

```adasnippet
type Node;
type Node_Acc is access Node;

type Node is record
   Content : Natural;
   Next    : Node_Acc;
end record;

type List is record
   Head : Node_Acc := null;
end record;
```

`Head` defaults to `null`, so a `List` that nobody has touched is a valid empty list rather than
something that needs initialising first.

### What to write

```adasnippet
procedure Push (L : in out List; Value : Natural);
function Length (L : List) return Natural;
function Sum (L : List) return Natural;
function Contains (L : List; Value : Natural) return Boolean;
```

- **`Push`** adds to the **front**. So pushing 1, then 2, then 3 leaves 3 at the head.
- **`Length`**, **`Sum`** and **`Contains`** each walk the list.

> [!TIP]
> Push is one statement:
>
> ```adasnippet
> L.Head := new Node'(Content => Value, Next => L.Head);
> ```
>
> The old head is read on the right before `L.Head` is assigned on the left, so the new node ends
> up in front of the list that was there. Reversing those two lines loses the whole list.

> [!TIP]
> Every walk is the same loop:
>
> ```adasnippet
> Current : Node_Acc := L.Head;
> ...
> while Current /= null loop
>    --  do something with Current.Content
>    Current := Current.Next;
> end loop;
> ```
>
> Stop at `null`, step with `Current.Next`. Get that shape right once and the other three
> subprograms are the same thing with a different middle.

> [!NOTE]
> An empty list must work in all four. `Head` is `null`, so the loop runs zero times and the
> answers are 0, 0 and `False` without a special case — provided the loop tests `Current` before
> dereferencing it, which is why the condition comes first.

> [!NOTE]
> This exercise is original to this course — see the note in Text Buffer.

Press **Check** when you are done.
