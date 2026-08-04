# Predefined exceptions

Ada defines four, and you have been raising the first one since chapter 5.

| Exception | Raised when |
|---|---|
| `Constraint_Error` | a value is outside its type's range, an index is out of bounds, arithmetic overflows, a division is by zero, or a null access is dereferenced |
| `Program_Error` | something arcane — an elaboration-order problem, a function ending without returning |
| `Storage_Error` | allocation fails, or the stack runs out |
| `Tasking_Error` | a task fails to activate, or a rendezvous goes wrong |

`Constraint_Error` is the one you will meet. It is the exception behind almost every check the
language performs on your behalf — which is why so much of this course could say "and that raises
`Constraint_Error`" without having explained exceptions yet.

## Do not reuse them

> "You should not reuse predefined exceptions. If you do then, it won't be obvious when one is
> raised that it is because something went wrong in a built-in language operation."

Raising `Constraint_Error` yourself makes it impossible to tell your deliberate signal from a
genuine bounds violation — and the handler that catches it will catch both. Declare your own; it
costs one line, as the first lesson showed.

> [!NOTE]
> `Storage_Error` from a stack overflow is worth knowing about because deep recursion produces it
> rather than a crash. It is catchable, though what you can safely do in the handler is limited —
> you are, by definition, short of stack.

Press **Run** to see three quite different mistakes all arrive as `Constraint_Error`.
