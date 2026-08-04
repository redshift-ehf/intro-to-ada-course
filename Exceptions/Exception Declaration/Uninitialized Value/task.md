## Exercise: Uninitialized Value

An enumeration with a value meaning "nobody has set this yet".

### The types

```adasnippet
type Option is (Uninitialized, Option_1, Option_2, Option_3);

Uninitialized_Error : exception;
```

`Uninitialized` is **first** on purpose. An `Option` variable that nobody initialises takes
`Option'First`, so the unset state is a value you can name and test rather than whatever happened
to be in memory.

### What to write

```adasnippet
function Image (O : Option) return String;
```

For `Uninitialized`, raise `Uninitialized_Error` with the message

```
Uninitialized value detected!
```

For anything else, return the option's name — `Option'Image` gives you `"OPTION_1"`.

> [!NOTE]
> **Why raise rather than return something?** Because there is no honest string to return.
> `"UNINITIALIZED"` reads like a real value and would flow onward into a log or a display; `""`
> looks like an empty answer rather than a missing one. The exception is the only answer that
> cannot be mistaken for a value.

> [!NOTE]
> The exception is called `Uninitialized_Error`, not `Uninitialized_Value` as in AdaCore's
> version. `Uninitialized_Value` is this package's own name here, and a declaration inside a
> package cannot share it without hiding it.

Press **Check** when you are done.
