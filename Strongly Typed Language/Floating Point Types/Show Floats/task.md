# Floating-point types

`Float` is predefined, and is usually the one you want:

```adasnippet
X : Float := 2.5;
```

The operations you would expect are all there, including `abs` and `**`.

## Precision

You can also ask for a precision, in decimal digits:

```adasnippet
type Precise is digits 12;
```

`digits 12` is a **requirement**, not a description: the compiler must give you a type carrying at
least twelve decimal digits, or refuse the declaration. You are stating what the program needs
rather than picking whichever size the hardware happens to offer.

## Range

A floating-point type can carry a range as well, and it is checked like any other:

```adasnippet
type Fraction is digits 6 range -1.0 .. 1.0;
```

> [!NOTE]
> **The bounds are not quite the literals you wrote**
>
> A floating-point type holds machine numbers. `-1.0` is one of those exactly — but most decimals
> are not. Write `range -273.15 .. 5504.85` and the bounds become the nearest representable
> values, which can sit a hair inside or outside the decimals you typed. That is binary floating
> point rather than anything Ada is doing, and it has a simple answer: use `'First` and `'Last`
> when you want the actual bound, and the question never comes up. The next exercise is built on
> exactly this.

Press **Run**, and count the digits in the two divisions before they stop agreeing.
