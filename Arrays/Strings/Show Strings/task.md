# Predefined array type: String

`String` is not built into the language as a special case. `Standard` declares it, and it is an
array like any other:

```adasnippet
type String is array (Positive range <>) of Character;
```

Everything in this chapter therefore applies to it: `'Range`, `'Length`, indexing, bounds checking,
slices, all of it.

## String literals are aggregates

`"Hello"` is notation for an array aggregate, so these two declarations produce the same value:

```adasnippet
A : String (1 .. 5) := "Hello";
B : String (1 .. 5) := ('H', 'e', 'l', 'l', 'o');
```

## Bounds from the value

`String` is unconstrained, so an object of it normally needs bounds — unless there is an initial
value to take them from:

```adasnippet
Message : constant String := "dlroW olleH";
--                 ^ no bounds written; they come from the literal
```

That works for any unconstrained array type, not just `String`:

```adasnippet
My_Array : constant Integer_Array := (1, 2, 3, 4);
```

> [!NOTE]
> An Ada `String` is a fixed-size object with fixed bounds — closer to a C array than to C++'s
> `std::string`. For text that grows and shrinks, the standard library has `Bounded_String` and
> `Unbounded_String`, which arrive in a later chapter.

Press **Run** to print a string backwards, one `Character` at a time.
