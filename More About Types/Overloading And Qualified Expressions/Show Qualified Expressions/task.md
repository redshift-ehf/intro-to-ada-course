# Overloading and qualified expressions

Two subprograms may share a name if they can be told apart:

```adasnippet
function F (A : Integer) return Integer;
function F (A : Character) return Integer;
```

## Return types count too

This is the unusual part. Ada resolves overloading on the **return** type as well as the
parameters:

```adasnippet
function Convert (Self : SSID) return Integer;
function Convert (Self : SSID) return String;

S : String := Convert (123_145_299);   --  picks the second
```

Nothing in the call distinguishes them. What does is that `S` is a `String`. You met this in the
Arrays chapter, where `Total` returned either a `Currency_Array` or a `Currency`.

> [!NOTE]
> An enumeration literal is treated as a parameterless function returning its type — which is
> exactly why `Red` can belong to two enumerations at once, as it did in the Records chapter.
> It is the same rule, not a special case for enumerations.

## When that is not enough

Add a third `Convert` and the call becomes genuinely ambiguous:

```adasnippet
function Convert (Self : SSID)    return String;
function Convert (Self : Integer) return String;

S : String := Convert (123_145_299);   --  which one?
```

`SSID` is derived from `Integer`, so the literal could be either. A **qualified expression** says
which type a value has:

```adasnippet
S2 : String := Convert (SSID'(123_145_299));
```

`Type'(expression)` — the tick and the parentheses.

## Not a type conversion

They look alike and do different things.

| | Qualified expression | Type conversion |
|---|---|---|
| Written | `SSID'(X)` | `SSID (X)` |
| Means | "this expression is an `SSID`" | "turn this into an `SSID`" |
| If it does not fit | it was never a candidate; compile error | `Constraint_Error` at run time |

A qualified expression *states* a type so overload resolution can proceed. A conversion *changes*
one.

> [!TIP]
> Qualification also works on aggregates — `Point'(12, 15)` — and that is where you will need it
> most, since a bare aggregate has no type of its own to be inferred from.
