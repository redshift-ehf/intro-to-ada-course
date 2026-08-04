# Dot notation

```adasnippet
O1.Foo;      --  the same call as
Foo (O1);
```

Ada supports the dot form whenever the dispatching parameter comes **first** — which is a good
reason to put it first.

Further parameters follow as usual:

```adasnippet
Obj.Bar (2);
```

## It is notation, nothing more

`O3.Foo` dispatches exactly when `Foo (O3)` would, and for the same reason. The dot does not make
a call dynamic and its absence does not make one static — only the declared type of the object
decides that, as the last lesson showed.

> [!NOTE]
> It also works on any tagged type's primitive, including inherited ones the derived type never
> mentioned. `Wide.Bump (100)` reaches the parent's `Bump` because nothing overrode it.

> [!TIP]
> Prefer the dot form for primitives of tagged types — it reads the way the rest of the world
> writes object-oriented code, and it makes the dispatching parameter obvious. Keep the bracket
> form for ordinary subprograms, where there is no "self" to put first.
