# The limitation of fixed-length strings

```adasnippet
S : String (1 .. 15);

S := "Hello";            --  does not compile
S := "Hello          ";  --  counts the spaces by hand
```

A `String` is an array of `Character`, and assigning to an array means assigning an array of
exactly the right length. There is no padding rule and no truncation rule, because those would be
rules about arrays in general.

The alternatives are no better:

```adasnippet
S (1 .. 5)      := "Hello";
S (6 .. S'Last) := (others => ' ');

S := ('H', 'e', 'l', 'l', 'o', others => ' ');
```

## When it is fine

```adasnippet
T : constant String := "No counting needed";
```

Initialised at its declaration, the length comes from the value and nobody counts anything. **This
is why every `String` you have written so far has been comfortable** — the course has been
declaring them with their values.

What a `String` cannot do is change. If a value arrives at run time, or grows, you want one of the
next two lessons:

| | maximum length | is it an array? |
|---|---|---|
| `String` | fixed at declaration | yes |
| `Bounded_String` | fixed at instantiation | no |
| `Unbounded_String` | none | no |

> [!NOTE]
> "Not an array" is doing the work in that table. It is what lets `Length` be a function rather
> than an attribute, lets assignment change what is stored, and removes every truncation argument
> from the last lesson.

> [!TIP]
> `String` is still the right type for a parameter. Both other types convert to it with
> `To_String`, so a subprogram taking `String` can be called from anywhere; one taking
> `Unbounded_String` cannot.
