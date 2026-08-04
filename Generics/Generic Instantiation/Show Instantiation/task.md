# Generic instantiation

`is new` turns a template into code:

```adasnippet
procedure Set_Main is new Set (T => Integer, Slot => Main);
```

Every formal gets an actual — the type `T` becomes `Integer`, the object `Slot` becomes `Main` —
and the result is a real procedure with a real name, callable like any other.

The same syntax covers everything:

```adasnippet
function Get_Main    is new ...
package Integer_Queue is new ...
```

You have already used one, in Access Types:

```adasnippet
procedure Free is new Ada.Unchecked_Deallocation (Integer, Int_Acc);
```

## Name the formals

```adasnippet
is new Set (T => Integer, Slot => Main)     --  clear
is new Set (Integer, Main)                  --  legal, and says nothing
```

Positional association is allowed and rarely worth it. A generic can easily have five formals of
three kinds, and a bare list of actuals in declaration order tells the reader nothing about which
is which.

> [!NOTE]
> An instantiation is a declaration, so it goes in a declarative part — the top of a procedure,
> a package spec, a package body. You cannot instantiate in the middle of a sequence of
> statements.

> [!TIP]
> Instantiating twice with the same actuals gives you two separate instances, not one shared.
> That is usually harmless and occasionally not — see the previous lesson on per-instance state.
