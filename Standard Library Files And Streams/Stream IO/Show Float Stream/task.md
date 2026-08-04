# Stream I/O

Sequential and direct I/O each hold one type, chosen at instantiation. Stream I/O holds anything,
and is **not generic**.

```adasnippet
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

F : File_Type;
S : Stream_Access;

Create (F, Out_File, File_Name);
S := Stream (F);

Float'Write (S, 1.5);
```

You do not read and write through the `File_Type`. You take a `Stream_Access` from it with
`Stream`, and then **the type's own attributes** do the work:

```adasnippet
Float'Write (S, Value);
Float'Read  (S, Value);
```

Every type has `'Read` and `'Write`. That is why a stream file can hold any mixture of them.

## The catch

**Nothing in the file says what type any of it was.** Read it back as something else and you get
whatever those bytes happen to mean — no error, no exception, just wrong numbers.

This is the one place in the language where strong typing is no help at all: the types are gone by
the time the data reaches the file. The next lesson is about the one discipline that helps.

> [!NOTE]
> `'Read` and `'Write` are overridable. A private type can define its own, which is how a type
> whose representation includes pointers can still be written sensibly — the ordinary definition
> would write the pointer.

> [!TIP]
> `Ada.Streams.Stream_IO` also has `Set_Index`, so a stream file supports random access as well.
> Be very careful: an index that does not land exactly on a value's first byte reads nonsense, and
> the element size is not fixed here the way it is for direct I/O.
