# Access types

An **access type** designates another type. A value of it is either `null` or the location of an
object of that type.

```adasnippet
type Date_Acc is access Date;

D : Date_Acc := null;
```

Ada calls these access types rather than pointers, and the difference is not only naming. There is
no pointer arithmetic, no implicit conversion to and from integers, and `null` is the default — an
access value is never left designating rubbish because somebody forgot to initialise it.

## They are still types

Two access types to the very same thing are two different types:

```adasnippet
type Date_Acc   is access Date;
type Date_Acc_2 is access Date;

D  : Date_Acc   := null;
D2 : Date_Acc_2 := D;   --  does not compile
```

Ada names types rather than comparing their shapes, and this is the same rule that made `Meters`
and `Feet` incompatible back in Strongly Typed Language. It applies here too.

## Reach for one last

Ada gives you a lot of ways not to need pointers at all: parameter modes instead of passing
addresses to be written through, unconstrained arrays and functions returning them instead of
allocating a buffer for a caller, records held by value instead of by reference. Most programs
that would need pointers in C need none here.

What is left — data structures that genuinely refer to themselves, or objects that must outlive
the scope that made them — is what this chapter is for.

Press **Run** to watch an access value go from `null` to designating a `Date`.
