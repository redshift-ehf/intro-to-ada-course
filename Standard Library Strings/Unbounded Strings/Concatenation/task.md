## Exercise: Concatenation

Join an array of unbounded strings, with two things optional.

### The package

```adasnippet
type Unbounded_Strings is array (Positive range <>) of Unbounded_String;

function Concat (USA            : Unbounded_Strings;
                 Trim_Str       : Boolean;
                 Add_Whitespace : Boolean) return Unbounded_String;

function Concat (USA            : Unbounded_Strings;
                 Trim_Str       : Boolean;
                 Add_Whitespace : Boolean) return String;
```

### What to write

Both bodies.

- **`Trim_Str`** — trim each element before joining it. Both ends.
- **`Add_Whitespace`** — a space between one element and the next. **Not after the last one.**

```
("Hello", " World", "!")            no trim, no ws  ->  Hello World!
(" This ", " _is_ ", "  a   ",
 " _check ")                        trim, no ws     ->  This_is_a_check
("  This  ", "  is a  ",
 "  test.  ")                       trim and ws     ->  This is a test.
("  Hi ")                           trim and ws     ->  Hi
```

The `String` version should call the `Unbounded_String` version rather than repeat it.

> [!TIP]
> `Trim` is `Ada.Strings.Unbounded`'s, taking and returning an `Unbounded_String`. `Both` — from
> `Ada.Strings` — means both ends.

> [!TIP]
> Return-type overloading again: inside the `String` version,
> `Joined : constant Unbounded_String := Concat (…);` reaches the other one, because
> `Unbounded_String` is what `Joined` is declared to be.

> [!NOTE]
> **`array of Unbounded_String` is legal and `array of String` is not.** `String` is indefinite,
> so the compiler cannot say how big an element would be; `Unbounded_String` is definite. That is
> the reason the exercise is shaped this way, and it is worth noticing before writing anything.

> [!NOTE]
> Trimming only removes the outside — `"   is a   "` becomes `"is a"`, keeping the inner space. And
> an element that is nothing but spaces trims away to nothing while still getting its separator,
> because the separator goes between *positions*. The test checks both.

Press **Check** when you are done.
