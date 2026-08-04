with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Variant_Records is
   type Expr;
   type Expr_Access is access Expr;

   type Expr_Kind_Type is (Bin_Op_Plus, Bin_Op_Minus, Num);

   --  Which components exist depends on the discriminant. A Num has a Val and no Left or Right;
   --  the two operators have Left and Right and no Val. One type, two shapes.
   type Expr (Kind : Expr_Kind_Type) is record
      case Kind is
         when Bin_Op_Plus | Bin_Op_Minus =>
            Left, Right : Expr_Access;
         when Num =>
            Val : Integer;
      end case;
   end record;

   --  A case expression over Kind reaches only the components that exist in each branch, so
   --  this is checked rather than trusted.
   function Eval (E : Expr) return Integer is
     (case E.Kind is
      when Bin_Op_Plus  => Eval (E.Left.all) + Eval (E.Right.all),
      when Bin_Op_Minus => Eval (E.Left.all) - Eval (E.Right.all),
      when Num          => E.Val);

   --  (12 - 15) + 3
   Tree : constant Expr :=
     (Bin_Op_Plus,
      new Expr'(Bin_Op_Minus, new Expr'(Num, 12), new Expr'(Num, 15)),
      new Expr'(Num, 3));

   Leaf : constant Expr := (Num, 12);
begin
   Put_Line ("(12 - 15) + 3 =" & Integer'Image (Eval (Tree)));
   Put_Line ("a leaf on its own =" & Integer'Image (Eval (Leaf)));
   Put_Line ("Leaf's kind is " & Expr_Kind_Type'Image (Leaf.Kind));

   --  `Leaf.Left` would raise Constraint_Error -- that component does not exist in a Num. It is
   --  checked at run time, not quietly reinterpreted as it would be in a C union.
end Show_Variant_Records;
