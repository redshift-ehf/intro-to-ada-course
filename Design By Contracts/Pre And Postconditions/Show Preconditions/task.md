# Pre- and postconditions

A contract is an obligation with two sides.

- A **precondition** is what the *caller* must guarantee on the way in.
- A **postcondition** is what the *implementer* guarantees on the way out.

```adasnippet
procedure DB_Entry (Name : String; Age : Natural)
  with Pre => Name'Length > 0;

function Square (A : Int_8) return Int_8 is (A * A)
  with Post => (if abs A in 0 | 1
                then Square'Result = abs A
                else Square'Result > A);
```

`Square'Result` names the value being returned. It exists only inside the postcondition.

## Talking about before and after

```adasnippet
procedure Square_All (A : in out Int_8_Array)
  with Post => (for all I in A'Range => A (I) = A'Old (I) * A'Old (I));
```

`A'Old` is the value a parameter had **before** the call. That is what lets a postcondition
describe a *change* rather than just a final state — "every element is now the square of what it
was" cannot be said any other way.

`(for all I in A'Range => ...)` and `(for some I in ...)` are quantified expressions, and they
are what make contracts over arrays readable.

## They must be switched on

**GNAT does not check any of this by default.** Without `-gnata`, every `Pre` and `Post` in your
program is ignored at run time — silently, with no warning.

This course's `course.gpr` passes `-gnata`, so contracts here are live. It was added when this
chapter was written, after measuring: a function with `Pre => X mod 2 = 0` accepted 3 and
returned 1.

> [!NOTE]
> That default is deliberate, not an oversight. Contracts cost time to check, and the intended
> workflow is to develop and test with them on and ship with them off — or better, to prove them
> statically with SPARK, at which point checking them at run time is redundant.

> [!TIP]
> A failing contract raises `Assertion_Error`, from `Ada.Assertions`. That is how the exercises
> in this chapter are tested, and how you can see one fire.

Press **Run**: a precondition catches an empty name, and another catches an overflow *before* it
happens rather than after.
