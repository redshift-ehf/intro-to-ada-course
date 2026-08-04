# Random discrete values

```adasnippet
with Ada.Numerics.Discrete_Random;

subtype Random_Range is Integer range 1 .. 10;

package R is new Ada.Numerics.Discrete_Random (Random_Range);
use R;

G : Generator;
X : Random_Range;
```

This one **is** generic, and the type parameter is where the range comes from. Changing the range
means changing the subtype and nothing else.

## Any discrete type

```adasnippet
type Suit is (Clubs, Diamonds, Hearts, Spades);

package Suits is new Ada.Numerics.Discrete_Random (Suit);
```

Enumerations, characters, modular types — anything discrete. No conversion, so nothing to get
wrong.

## Why it matters that the range is a type

The version everyone writes in other languages is:

```adasnippet
Random (G) mod 6 + 1
```

and it is **subtly biased** whenever the range does not divide the generator's period — the low
values come up slightly more often. It is a real bug and an invisible one.

Declaring the subtype hands that problem to the implementation, which is required to distribute
uniformly over the type.

> [!TIP]
> `Reset (G, Seed)` works here too, and the example uses it — five cards from seed 7, the same
> five every run.
