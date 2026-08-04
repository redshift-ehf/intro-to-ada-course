# Basic encapsulation

A package spec has two halves, and the keyword `private` is the line between them:

```adasnippet
package Encapsulate is

   procedure Hello;

private

   procedure Hello2;
   --  not visible outside

end Encapsulate;
```

Everything before `private` is what the package offers. Everything after is visible only to the
package's own body and to its children — declared, real, callable from inside, and simply not
there as far as any other unit is concerned.

```adasnippet
Encapsulate.Hello;    --  fine
Encapsulate.Hello2;   --  does not compile
```

## Why bother

Because the public half is a promise. Anything a caller can reach, they will reach, and then you
cannot change it. Putting the rest behind `private` is what leaves you free to rewrite the
implementation later without breaking anybody — and the compiler enforces the boundary, so it
cannot erode quietly the way a naming convention does.

> [!NOTE]
> This is a *compile-time* boundary, not a runtime one. There is no cost to it in the finished
> program, and no way around it either.

> [!TIP]
> Uncomment the `Greeter.Hello2;` line in the example and press **Run**. The error names the
> boundary you crossed.
