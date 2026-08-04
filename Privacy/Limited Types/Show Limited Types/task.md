# Limited types

`limited private` takes away the two operations a plain private type keeps:

```adasnippet
type Stack is limited private;
--  no assignment, no predefined equality
```

```adasnippet
S, S2 : Stack;
begin
   S := S2;   --  does not compile
```

Whatever a limited type can do, somebody declared. Nothing comes for free.

## When that is what you want

Whenever copying would be **wrong** rather than merely wasteful.

A file handle, a lock, a hardware register, a network connection: copy one and you have two names
for a single underlying thing. Close through the first and the second is stale — pointing at a
file that is shut, a lock that is released. It compiles, it runs, and it fails somewhere else
entirely.

`limited` moves that from a runtime mystery to a compile error.

The same argument covers anything with identity rather than just value — a list that owns its
contents, an object that registered itself somewhere on creation.

> [!NOTE]
> You can still declare limited objects, pass them as parameters, and change them through
> procedures. What you cannot do is *copy* one. Note also that a function may return a limited
> type — it is built in place rather than copied out — which is how the next exercise's `Init`
> works.

> [!TIP]
> If you want equality on a limited type, declare `"="` yourself and define it to mean what it
> should. The next exercise does exactly that, and its version deliberately does not mean "these
> two are identical".
