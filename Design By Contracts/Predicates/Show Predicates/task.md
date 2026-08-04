# Predicates

A predicate is a rule about a **type** rather than a subprogram: which values of it are legal.

## Static predicates

Checked at compile time where possible, and limited to scalar types:

```adasnippet
subtype Test_Days is Work_Week
  with Static_Predicate => Test_Days in Mon | Wed | Fri;
```

A range constraint can say `Mon .. Fri`. It cannot say Monday, Wednesday and Friday — those are
not contiguous. That is what static predicates are for, and the subtype can still be used in a
`for` loop and a `case`, which is what makes them worth having over a plain check.

## Dynamic predicates

Checked while the program runs, and may say anything:

```adasnippet
type Tests_Week is array (Week) of Natural
  with Dynamic_Predicate =>
    (for all I in Tests_Week'Range =>
       (case I is
           when Test_Days => Tests_Week (I) > 0,
           when others    => Tests_Week (I) = 0));
```

## When they are checked, and when they are not

This is the part to remember.

| | checked? |
|---|---|
| assigning one component or element | **no** |
| assigning the whole object | yes |
| passing the object to a subprogram | yes |
| returning it, converting it, qualifying it | yes |

Element-by-element assignment deliberately escapes the check, so an object can be built up a
piece at a time without every half-finished state having to be valid. The check happens when the
object is *used* as a whole.

> [!TIP]
> That is a feature and a trap. `Num_Tests (Tue) := 2;` leaves an invalid array sitting there
> quite happily, and the error surfaces at the next call that takes it. If you want the check
> sooner, assign the whole object.

> [!NOTE]
> Predicates need `-gnata` exactly as preconditions do. See the previous lesson.
