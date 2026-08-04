# Dispatching operations

Which body runs depends on how the object is *declared*, not on what it contains.

```adasnippet
O1 : My_Class := ...;
O2 : Derived  := ...;
O3 : My_Class'Class := O2;

Foo (O1);   --  static:      My_Class.Foo
Foo (O2);   --  static:      Derived.Foo
Foo (O3);   --  dispatching: Derived.Foo
```

The first two are settled at compile time — the type is known, so there is nothing to look up.
Only the classwide one consults the tag.

**This is the opposite default from most object-oriented languages**, where every method call on
an object dispatches. In Ada you pay for dispatch only where you asked for it, and you can see
where that is by looking at the declarations.

## View conversion

```adasnippet
O2 : My_Class := My_Class (O1);   --  O1 is a Derived
```

A view conversion looks at the same object *as* its parent type. Dispatch then follows the view,
so a classwide variable initialised from it reaches `My_Class.Foo` rather than `Derived.Foo`.

> [!TIP]
> If a call is not dispatching when you expected it to, look at the declared type of the thing
> you passed. Nine times in ten it is a `T` where it wanted to be a `T'Class`.
