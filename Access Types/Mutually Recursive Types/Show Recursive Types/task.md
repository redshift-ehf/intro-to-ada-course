# Mutually recursive types

A list node holds an access to a node. So `Node` needs `Node_Acc`, and `Node_Acc` needs `Node`, and
one of them has to be written first.

An **incomplete type declaration** breaks the circle:

```adasnippet
type Node;                    --  Node exists. What is in it comes later.

type Node_Acc is access Node; --  enough to declare this

type Node is record           --  and now the full declaration
   Content    : Natural;
   Prev, Next : Node_Acc;
end record;
```

`type Node;` promises the type and says nothing about it. That is all an access type needs, because
an access value is the same size whatever it designates.

## The rule

Between the incomplete declaration and the full one, `Node` may only be used where its size is not
needed — which in practice means as the target of an access type. You cannot declare a `Node`
variable there, or a record component of type `Node`. The full declaration must appear in the same
declarative region.

> [!NOTE]
> This is also how a type refers to *itself*, which is the more common case. A binary tree node
> holds two accesses to its own type, and needs the same incomplete declaration first.

> [!TIP]
> Watch what the example does with a `constant`:
>
> ```adasnippet
> First : constant Node_Acc := new Node'(...);
> First.Next := Second;   --  allowed
> ```
>
> The access value never changes; the node it designates does. Building a list out of constants
> is not a trick, it is the ordinary case — you rarely want to repoint a node, only to fill it in.
