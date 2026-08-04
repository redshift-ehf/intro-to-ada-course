## Exercise: Limited Strings

A string that cannot be copied by accident.

### The type

```adasnippet
type Lim_String is limited private;

function Init (S : String) return Lim_String;
function Init (Max : Positive) return Lim_String;
procedure Put_Line (LS : Lim_String);
procedure Copy (From : Lim_String; To : in out Lim_String);
function "=" (Ref, Dut : Lim_String) return Boolean;

private

   type Lim_String is access String;
```

The private part is why this is limited. `Lim_String` is an **access** type, so the assignment Ada
would give you for free copies the pointer — leaving two names for one `String`, and a change
through either visible through both. That is almost never what somebody writing `A := B` meant.

So assignment is removed, and `Copy` is provided instead to do the thing that was actually
wanted.

### What to write

**`Copy`** — copy as much of `From` as fits in `To`, then fill the rest of `To` with underscores.
`To` keeps its own length; it is never resized.

**`"="`** — compare only as far as the **shorter** of the two. So `"Hello World"` equals
`"Hello"`, and equals `"Hello World_________"` as well.

> [!NOTE]
> That equality is deliberately not "these are the same string". It is the one the exercise
> specifies, and declaring it explicitly is what makes it possible to say so — a predefined `=`
> would have compared the access values, which would have meant "these are the same object", a
> third thing again. Three plausible meanings, and `limited` forces you to pick.

> [!TIP]
> `Put_Line` here is this package's own, not `Ada.Text_IO`'s. Inside the body, call the standard
> one by its full name or you will have written a procedure that calls itself.

Press **Check** when you are done.
