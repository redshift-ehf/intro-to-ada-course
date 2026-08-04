# Child packages & privacy

A child package can see its parent's private part. Not all of it, and not from everywhere — the
rule is precise, and it is what makes private types extensible without being leaky.

| | can see the parent's private part? |
|---|---|
| child's **body** | yes |
| child's **private** part | yes |
| child's **public** part | **no** |

The reason for the last row: a child's public part is visible to everyone, so anything it could
see, everybody could see — and the parent's privacy would be worth nothing.

## What it buys you

You can add operations to a private type **from outside the parent**, without reopening it and
without exposing its structure to anyone else:

```adasnippet
package body Show_Child_Privacy.Ops is

   function Image (R : Reading) return String is
   begin
      return Integer'Image (R.Celsius) & " C";
      --                      ^ reachable here, and nowhere outside the family
   end Image;

end Show_Child_Privacy.Ops;
```

A caller of `Ops.Image` still cannot touch `R.Celsius`. The child body can. That is the whole
mechanism, and it is how a large private type grows a wide set of operations without either
becoming one enormous package or giving up its privacy.

Private subprograms work the same way — `Warmer` calls the parent's private `Doubled`,
unqualified, as though it were its own.

> [!NOTE]
> This task is four files and no `Run` button: a child package must be a library unit, so unlike
> the earlier examples it cannot be nested inside a procedure. Read the four in order — parent
> spec, parent body, child spec, child body — and note which of them can name `Celsius`.

> [!TIP]
> A child's private part seeing the parent's private part is what lets you write
> `E : Priv_Rec := (Number => 99);` there. Move that same declaration to the child's public part
> and it stops compiling, for the reason in the table above.
