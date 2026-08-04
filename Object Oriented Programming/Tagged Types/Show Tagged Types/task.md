# Tagged types

`tagged` adds one thing to a record: **every object carries a tag** saying what it really is.
Everything else in this chapter follows from that.

```adasnippet
type Shape is tagged record
   Name : Character := '?';
end record;

procedure Describe (Self : Shape);   --  a primitive, as before
```

Methods stay outside the type, as ordinary subprograms in the same package. There is no
`class { ... }` and nothing is *inside* anything — which means adding an operation to a type is
the same act as declaring a subprogram.

## Extending

```adasnippet
type Circle is new Shape with record
   Radius : Float := 0.0;
end record;

overriding procedure Describe (Self : Circle);
```

`with record` adds components, which a plain derived type could not. `with null record` adds
none, and is how you extend a type without adding data.

## Write `overriding`

It is optional. Write it anyway: when it is present the compiler checks that something really is
being overridden, so a misspelled or mistyped profile fails to compile instead of quietly
declaring a *new* operation that nothing ever calls. That mistake is silent in most languages
with inheritance, and it is a bad one.

> [!TIP]
> `not overriding` says the opposite, and is worth it on an operation you mean to be new — it
> fails if you accidentally collide with something inherited.

> [!NOTE]
> An extension's aggregate names the parent's components first and then its own:
> `(Name => 'c', Radius => 2.0)`.
