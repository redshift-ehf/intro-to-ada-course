# Dereferencing

`.all` is the explicit dereference — the whole object an access value designates:

```adasnippet
Today : Date := D.all;
```

That is an ordinary assignment, so `Today` is a **copy**. Changing what `D` designates afterwards
does not touch it.

## Usually you can leave it out

For a component, the dereference is implicit:

```adasnippet
J : Integer := D.Day;   --  means D.all.Day
```

Same for indexing an access-to-array and for calling through an access-to-subprogram. There is no
separate `->` to remember, because there is no distinction to draw: `D.Day` can only mean one
thing.

## The distinction that matters

Two different things can be assigned, and they are not the same:

```adasnippet
A := B;         --  A now designates what B designates. Two names, one object.
A.all := B.all; --  the object A designates now holds a copy of the object B designates.
```

The first changes a pointer. The second changes an object. Most confusion about pointers in any
language comes down to reading one of these and meaning the other — and in Ada they are visibly
different, which is much of why `.all` is spelled out at all.

> [!NOTE]
> A **constant** access value can still be used to change what it designates:
>
> ```adasnippet
> D : constant Date_Acc := new Date'(...);
> D.Day := 1;   --  fine
> D := null;    --  not fine
> ```
>
> `constant` applies to the access value, not to the object at the end of it.
