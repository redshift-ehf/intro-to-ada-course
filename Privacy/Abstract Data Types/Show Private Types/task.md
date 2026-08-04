# Abstract data types

A **private type** publishes its name and hides its structure:

```adasnippet
package Stacks is

   type Stack is private;

   procedure Push (S : in out Stack; Val : Integer);
   procedure Pop (S : in out Stack; Val : out Integer);

private

   type Stack is record
      Top     : Stack_Index;
      Content : Content_Type;
   end record;

end Stacks;
```

Outside the package, `Stack` is a type you can declare, assign and compare — and nothing else.
`S.Top` does not compile. Neither do the helper types `Stack_Index` and `Content_Type`, which stay
behind `private` where they belong.

## What you get

The implementation becomes yours to change. Swap that record for an array, an access type, a
different layout entirely, and no code outside the package needs touching — because no code
outside the package was allowed to depend on it.

This is what "abstract data type" means: a type defined by what it *does*, with the how kept out
of the contract.

## The two operations that survive

Assignment and equality. Every non-limited private type keeps them, and they behave the obvious
way — assignment copies the whole value, equality compares the whole value, both without the
caller knowing what "the whole value" consists of.

> [!TIP]
> Declare the private type's operations in the public part, and *everything* else after
> `private`. A helper type that leaks into the public part is a promise you did not mean to make.
