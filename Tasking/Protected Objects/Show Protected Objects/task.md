# Protected objects

Two tasks changing the same variable is a race, and the damage is silent. `Local := Local + 1` is
a read and a write; two tasks interleaving them lose an update, and nothing reports it.

A **protected object** encapsulates the data and lets one task in at a time:

```adasnippet
protected Obj is
   procedure Set (V : Integer);
   function Get return Integer;
private
   Local : Integer := 0;
end Obj;
```

It reads like a small package — operations in front, data behind `private`. What it adds is the
guarantee that no two tasks are ever inside it at once.

## Procedures and functions differ

| | May change the data | Concurrent callers |
|---|---|---|
| `procedure` | yes | one at a time |
| `function` | **no** | several at once |

A function is read-only and the compiler enforces it, which is what makes it safe to let several
readers in together. That is not a micro-optimisation: for data read far more often than written,
it is most of the reason to use a protected object rather than a lock.

## Why not a task?

You *can* protect data with a task — it was the only way in Ada 83. A protected object is
cheaper: no separate thread of control, no rendezvous, just a lock around a small piece of data.
Reach for a task when something needs to *do* things, and a protected object when something needs
to *hold* things.

Press **Run**: four tasks, a thousand increments each, and the answer is exactly 4000 every time.
