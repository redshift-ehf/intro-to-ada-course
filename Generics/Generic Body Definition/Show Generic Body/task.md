# Generic body definition

The body of a generic does **not** repeat `generic`, and does not repeat the formals:

```adasnippet
generic
   type T is private;
   X : in out T;
procedure Set (E : T);

procedure Set (E : T) is
--  no `generic` here
begin
   X := E;
end Set;
```

It is an ordinary body that happens to use `T` and `X`, which are in scope because the
specification declared them. That is all there is to the rule, and it is worth stating only
because writing `generic` again is the obvious mistake.

## Each instance gets its own everything

This is the part that surprises people. Instantiating a generic copies **all** of it, state
included:

```adasnippet
package Int_Holder   is new Holder (T => Integer, Initial => -1);
package Float_Holder is new Holder (T => Float,   Initial => 0.5);
```

If `Holder`'s body declares a variable, `Int_Holder` and `Float_Holder` have one each. They are
not sharing anything — two instantiations are two separate pieces of code that happen to have been
written once.

> [!TIP]
> That is a feature when you want a counter per instance, and a trap when you expected one shared
> across all of them. If you want shared state, put it somewhere non-generic and pass it in as a
> formal object.

Press **Run** and note that changing the integer holder leaves the float one alone.
