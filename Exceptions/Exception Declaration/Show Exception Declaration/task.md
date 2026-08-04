# Exception declaration

An Ada exception is an **object**, not a type:

```adasnippet
My_Except : exception;
```

That is the whole declaration. It goes wherever a declaration goes — in a package spec to be
raised and handled across units, or locally to a subprogram.

> [!NOTE]
> **In other languages**
>
> Java and Python exceptions are classes: you define a type, and raising means constructing an
> instance of it. Ada's are objects, and each one is a *kind* of exception. There is no hierarchy
> and no inheritance between them — `Too_Small` and `Too_Large` are simply two different things,
> and a handler for one does not catch the other.

## No `throws` clause

Ada does not require a subprogram to declare what it might raise, and there is nothing like Java's
checked exceptions. That is a deliberate trade: the compiler will not remind you, so an exception a
package can raise belongs in its documentation, and usually in its spec beside the subprogram that
raises it.

## Declare your own

```adasnippet
Too_Small : exception;
Too_Large : exception;
```

Two exceptions rather than one with a message, when the two cases want handling differently. One
with a message, when they do not. The next lesson covers messages.

Press **Run** and watch three separate kinds get caught by three separate handlers.
