# Unconstrained arrays

So far every array type has fixed how long its values are. `range <>` declines to:

```adasnippet
type Workload_Type is array (Days range <>) of Natural;
--                                 ^ indexed by Days, bounds decided later
```

This is an **indefinite** type: it says what indexes the array and what the array holds, but not
where the index starts and stops. You cannot make one without saying:

```adasnippet
Workload : constant Workload_Type (Monday .. Friday) := (Friday => 7, others => 8);
```

The bounds are given when the object is created, and are fixed from then on.

## Restrictions

An array's bounds are settled when it comes into existence and never change afterwards. So this is
rejected outright:

```adasnippet
A : String;   --  no bounds, and no value to take them from
```

and this compiles but is wrong:

```adasnippet
A : String := "Hello";
begin
   A := "World";        --  fine, same length
   A := "Hello World";  --  Constraint_Error, different length
```

The elements of an array are as changeable as any other variable. The *shape* of it is not.

> [!NOTE]
> **In other languages**
>
> This is not C's variable-length array. An unconstrained array instance is an ordinary object,
> usually on the stack, with no heap allocation behind it and nothing to free. What varies is
> from one object to the next — not, during its life, within one.

> [!TIP]
> `others => 8` in that aggregate covers every index not named. It is the same `others` as in a
> record aggregate and a case statement.
