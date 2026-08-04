## Exercise: Price list

A list of prices — and a round-up of the last three chapters.

### The types

```adasnippet
type Price_Type is delta 10.0 ** (-2) digits 12;

type Prices (Max : Positive) is limited private;

type Price_Result (Ok : Boolean := False) is record
   case Ok is
      when True  => Price : Price_Type;
      when False => null;
   end case;
end record;
```

Four things at once, each from where you met it:

- **decimal fixed-point** for the prices, so the arithmetic is exact in cents;
- a **discriminant** for how many fit;
- a **variant record** for the result of a lookup;
- **limited private** for the list itself.

Note what `Price_Result` makes impossible. There is no `Price` component when `Ok` is `False`, so
there is no meaningless zero to mistake for an answer — the failure case has nothing in it to read.

### What to write

```adasnippet
procedure Add (P : in out Prices; Item : Price_Type);
function Get (P : Prices; Idx : Positive) return Price_Result;
procedure Display (P : Prices);
```

- **`Add`** appends, if there is room.
- **`Get`** returns the price at an index, or `(Ok => False)` if there is none.
- **`Display`** prints `PRICE LIST` and then one price per line.

`Reset` and `Count` are written for you.

> [!TIP]
> `Price_Type'Image` gives `" 1.45"` with a leading space, as every `'Image` does. The expected
> output keeps it.

> [!NOTE]
> This exercise is adapted from AdaCore's *Laboratories*, where it appears twice — in More about
> types and again here with the list made limited. It is ported once, at this second site, because
> only here has the course taught everything it needs.

Press **Check** when you are done.
