# Vectors and matrices

```adasnippet
with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;

V1 : constant Real_Vector := (1.0, 3.0);

M1 : constant Real_Matrix := ((1.0, 5.0, 1.0),
                              (2.0, 2.0, 1.0));
```

Bounds come from the aggregate. Explicit ranges also work:
`Real_Matrix (1 .. 2, 1 .. 3) := …`.

## What is in the package

`+`, `-`, `*`, `abs`, and then the linear algebra:

```adasnippet
Transpose (M)
Inverse (M)
Determinant (M)
Solve (M, V)        --  M x = V
Eigenvalues (M)
```

## Two multiplications

```adasnippet
V1 * V2   --  Float       -- the inner product
V1 * V2   --  Real_Matrix -- the outer product
```

The same operands and the same operator, told apart by **what the result is used as** — return-type
overloading, from More About Types, doing something you would otherwise need two names for.

## When it does not work

```adasnippet
Inverse (((1.0, 2.0), (2.0, 4.0)))   --  raises Constraint_Error
```

A singular matrix has no inverse, and the determinant is 0.0. `Solve` on the same matrix raises
too.

> [!NOTE]
> `Real_Arrays` is `Generic_Real_Arrays` instantiated for `Float`, exactly as the elementary
> functions were. `Complex_Arrays` is the matching package for complex matrices.

> [!TIP]
> Bounds are checked. `M1 * M2` with mismatched dimensions raises `Constraint_Error` rather than
> reading past the end — which is the reason to use this package instead of writing the loops.
