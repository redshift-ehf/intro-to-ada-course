# Package body

Once a package declares a subprogram, it needs a body — the spec promised something and the body
has to deliver it. Leave it out and the program will not link.

```adasnippet
package Counter is
   procedure Bump;
   function Value return Integer;
end Counter;
```

## What the body can hide

A declaration in the **body** is invisible outside it. `Count` below cannot be read or written by
anything else in the program:

```adasnippet
package body Counter is
   Count : Integer := 0;   --  private to this file
   ...
end Counter;
```

This is the plainest encapsulation Ada offers, and it costs nothing: no keyword, no ceremony.
Anything the outside world does not need to see simply goes in the body.

> [!TIP]
> Press **Run**, then try adding `Counter.Count := 5;` to a program that withs it. The error is
> the point.
