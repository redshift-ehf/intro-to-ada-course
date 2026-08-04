## Exercise: Colors, private

The Records chapter's colours again, with `RGB` made **private**.

### What changed

```adasnippet
type RGB is private;

function Red_Of (C : RGB) return Int_Color;
function Green_Of (C : RGB) return Int_Color;
function Blue_Of (C : RGB) return Int_Color;

private

   type RGB is record
      Red   : Int_Color;
      Green : Int_Color;
      Blue  : Int_Color;
   end record;
```

The record is still a record. What has gone is anybody else's ability to *say so*. In the Records
chapter the test wrote `To_RGB (Salmon).Red`; that no longer compiles, which is why the three
accessor functions exist.

### What to write

`Red_Of`, `Green_Of` and `Blue_Of`. Each returns one channel — three one-line bodies, inside the
package, where the components are visible.

> [!NOTE]
> **A private type keeps two operations**: assignment and equality. You can still write
> `Copy : RGB := Some_Colour;` and `A = B`. That is exactly what `limited private` takes away,
> two lessons from now — and the test here checks that both still work, so the difference is
> concrete when you meet it.

> [!NOTE]
> **Why the file is `private_colors.adb`.** This is the third `Colors` in the course — Strongly
> Typed Language has `Colors`, Records has `Record_Colors`. One GNAT project is one namespace, so
> the third takes the third qualifier.

Press **Check** when you are done.
