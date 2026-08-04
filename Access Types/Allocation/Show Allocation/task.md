# Allocation

`new` allocates, and there are three shapes of it.

## By type

```adasnippet
D : Date_Acc := new Date;
```

Allocates a `Date` and leaves it at whatever defaults the type declares. Components with no
default start as nothing in particular, exactly as an uninitialised variable would.

## With a value

```adasnippet
D : Date_Acc := new Date'(30, November, 2011);
```

A **qualified expression** after `new` allocates and initialises in one step. This is what you want
almost every time — there is no window in which the object exists but means nothing.

Note the tick: `Date'(...)`, the qualified expression from More About Types. An aggregate has no
type of its own, so it has to be told which one it is.

## With bounds

An unconstrained type has no fixed size, so allocating one means settling that. Either say the
bounds:

```adasnippet
Buffer : String_Acc := new String (1 .. 10);
```

or give it a value to take them from:

```adasnippet
Msg : String_Acc := new String'("Hello");
```

Once allocated, those bounds are fixed for that object's lifetime — the same rule as any other
array, and the reason the first form needs a size at all.

> [!NOTE]
> Allocated objects go in a *storage pool*. The default one is the heap, and unlike a stack
> object, what `new` returns lives until it is freed rather than until the enclosing scope ends.
> That is the whole point, and also the whole difficulty — see Other Features.
