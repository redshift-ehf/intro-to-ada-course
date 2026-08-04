# Mixed types, and unbounded ones

```adasnippet
procedure Output (S : Stream_Access; FV : Float; SV : String) is
begin
   String'Output (S, SV);
   Float'Output (S, FV);
end Output;

procedure Input_Display (S : Stream_Access) is
   SV : constant String := String'Input (S);
   FV : constant Float  := Float'Input (S);
begin
   ...
```

Two types in one file, one of them a different length each time. Neither is possible with
sequential or direct I/O.

## 'Output and 'Input, not 'Write and 'Read

For an **unbounded** type — a `String`, or a record with a discriminant — the bounds are not part
of the type, so they have to go into the file too:

| | writes | reads |
|---|---|---|
| `'Write` / `'Read` | the value | into an object that already exists |
| `'Output` / `'Input` | bounds, then the value | makes an object of the right size |

`'Input` is a **function**, and has to be: it reads the bounds first, then produces an object of
that size. `'Read` cannot do that — it takes an object it has to fit into.

`String'Write` on a 12-character label puts twelve characters and nothing else. Nothing can read
them back, because nothing knows there were twelve.

## Order is the format

The file records nothing about what is in it. **Read the types back in the order they were
written, or the data is corrupt** — and no exception will tell you.

The discipline in the example is the answer: one procedure that writes a record's worth, one that
reads it, next to each other. The order then exists in exactly one place instead of being spread
across the program.

> [!TIP]
> `'Output` on a definite type works too, and costs nothing extra for most of them. Using it
> uniformly is a reasonable house rule — it removes the question of which attribute a given type
> needs.
