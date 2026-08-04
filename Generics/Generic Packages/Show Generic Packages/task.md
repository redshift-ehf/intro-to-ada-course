# Generic packages

Same syntax, `package` instead of a subprogram:

```adasnippet
generic
   type T is private;
package Element is

   procedure Set (E : T);
   function Get return T;
   function Is_Valid return Boolean;

   Invalid_Element : exception;

private
   Value : T;
   Valid : Boolean := False;
end Element;
```

```adasnippet
package I is new Element (T => Integer);
package S is new Element (T => Character);
```

`I` and `S` are two ordinary packages. `I.Set (5)` and `S.Get` work exactly as they would if you
had written both packages by hand.

## Everything is instantiated

The private `Value` and `Valid` are part of the template, so each instance gets its own pair. `I`
and `S` have a store each; setting one does not touch the other.

This is what makes generic packages worth having. A generic subprogram gives you an algorithm; a
generic package gives you a **type together with its state and its operations** — which is most of
what the standard library's containers are.

> [!NOTE]
> `Invalid_Element : exception;` is instantiated too. `I.Invalid_Element` and `S.Invalid_Element`
> are two different exceptions, so a handler for one will not catch the other. Usually right, and
> worth knowing before it surprises you.

> [!TIP]
> Generic packages are how you write a container. The Generic List exercise below is one, and the
> Ada standard library's `Ada.Containers.Vectors` is the same idea at full size.
