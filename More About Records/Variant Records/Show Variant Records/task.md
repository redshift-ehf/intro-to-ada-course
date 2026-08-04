# Variant records

A discriminant can decide **which components exist**:

```adasnippet
type Expr (Kind : Expr_Kind_Type) is record
   case Kind is
      when Bin_Op_Plus | Bin_Op_Minus =>
         Left, Right : Expr_Access;
      when Num =>
         Val : Integer;
   end case;
end record;
```

A `Num` has a `Val` and no `Left`. The two operators have `Left` and `Right` and no `Val`. One
type, two shapes, and which one an object has is fixed when it is created.

## The check is real

```adasnippet
E : Expr := (Num, 12);
E.Left := new Expr'(Num, 15);   --  Constraint_Error
```

`Left` does not exist in a `Num`, and reading or writing it raises. Not undefined behaviour, not a
silent reinterpretation of whatever bytes are there — an exception, at the point of the mistake.

## Reaching them safely

Inside a `case` over the discriminant, only the components of that branch are in view:

```adasnippet
function Eval (E : Expr) return Integer is
  (case E.Kind is
   when Bin_Op_Plus  => Eval (E.Left.all) + Eval (E.Right.all),
   when Bin_Op_Minus => Eval (E.Left.all) - Eval (E.Right.all),
   when Num          => E.Val);
```

Every access is correct by construction, and the compiler checks the case covers every kind. This
is the shape almost all variant-record code takes.

> [!NOTE]
> **In other languages**
>
> This is a sum type — `enum` in Rust, a tagged union in ML or Haskell — and it is what a C `union`
> gestures at without the safety. A C union has no idea which member is live; an Ada variant record
> carries that in the discriminant and checks it.

> [!TIP]
> Note that `Expr` also refers to itself through `Expr_Access`, using the incomplete declaration
> from the last chapter. Variant records and access types together are how you write a tree.
