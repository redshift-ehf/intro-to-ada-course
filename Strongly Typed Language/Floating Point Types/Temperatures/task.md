## Exercise: Temperatures

Write a package that converts between Celsius and Kelvin.

### The types

```adasnippet
type Celsius     is digits 6 range -273.15 .. 5504.85;
type Int_Celsius is range -273 .. 5505;
type Kelvin      is digits 6 range 0.0 .. 5778.0;
```

The bounds run from absolute zero to the surface of the Sun, which is why they look so arbitrary:
−273.15 °C is 0 K, and 5504.85 °C is 5778 K.

### What to write

```adasnippet
function To_Celsius     (T : Int_Celsius) return Celsius;
function To_Int_Celsius (T : Celsius)     return Int_Celsius;
function To_Celsius     (K : Kelvin)      return Celsius;
function To_Kelvin      (C : Celsius)     return Kelvin;
```

The two scales differ by 273.15. Going to `Int_Celsius` is a plain type conversion — and Ada
rounds to nearest rather than truncating, so 25.6 becomes 26 and −273.15 becomes −273.

### Clamp rather than trust

A `Clamp` function is written for you, and every conversion here should go through it. There are
two separate reasons, and neither is caution for its own sake:

- `Int_Celsius` reaches 5505 while `Celsius` stops at 5504.85, so at the top the two ranges
  genuinely do not line up.
- −273.15 has no exact binary representation. A conversion that is correct to every digit the type
  carries can still land a fraction outside the target's range, and that raises `Constraint_Error`
  on a right answer.

> [!NOTE]
> `To_Celsius` is declared twice, once for each source type. That is overloading, and Ada picks
> between them by the argument, so nothing needs disambiguating at the call site.

> [!TIP]
> For the same reason as above, write `Celsius'First` rather than `-273.15` whenever you mean the
> bottom of the scale. The literal is not guaranteed to be a value of the type; the attribute
> always is.

Press **Check** when you are done.
