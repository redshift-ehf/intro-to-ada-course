# Records with discriminant

A **discriminant** is a component that is part of the type, chosen per object, and fixed once
chosen:

```adasnippet
type Growable_Stack (Max_Len : Natural) is record
   Items : Items_Array (1 .. Max_Len);
   Len   : Natural := 0;
end record;
```

Now a `Growable_Stack (4)` and a `Growable_Stack (128)` are two objects of **one type**, different
sizes. One procedure takes both.

## What follows from it

**It cannot be changed.** A discriminant is settled when the object is created and is read-only
thereafter — which it has to be, since `Items`' bounds depend on it.

**It makes the type indefinite.** With no default, an object must say which constraint it has:

```adasnippet
S : Growable_Stack;        --  rejected: which size?
S : Growable_Stack (4);    --  fine
```

That is the same rule as an unconstrained array type, for the same reason.

**Unless it has a default:**

```adasnippet
type Point (X, Y : Natural := 0) is record
   null;
end record;

P1 : Point;            --  takes the defaults
P2 : Point (1, 2);     --  constrained here
P3 : Point := (1, 2);  --  constrained by its value
```

With defaults the type is definite again, and `P1` is legal.

> [!NOTE]
> `record null; end record;` is a record with no components at all — only discriminants. Perfectly
> legal, and occasionally what you want.

> [!TIP]
> Read a discriminant like any component: `S.Max_Len`. Only assigning to it is refused, and the
> error says so plainly.
