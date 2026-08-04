# Formal type declaration

A formal type says what kind of type will be supplied. It is a **two-sided bargain**: it limits
what may be instantiated, and it decides what the body is allowed to do.

| Written | Accepts | So the body may |
|---|---|---|
| `type T is private;` | any definite type | assign, compare with `=` |
| `type T (<>) is private;` | any type, definite or not | assign, compare — but not declare an uninitialised `T` |
| `type T is (<>);` | discrete: integer or enumeration | loop over it, use `'First`, `'Succ`, `'Pos` |
| `type T is range <>;` | any signed integer type | do integer arithmetic |
| `type T is digits <>;` | any floating-point type | do floating-point arithmetic |

Promise less and more types qualify. Promise more and the body can do more. That is the whole of
it, and choosing well is most of the skill.

## Definite and indefinite

`is private` quietly promises the type is **definite** — its size is known, so the body may
declare a variable of it. `String` is not definite, so:

```adasnippet
function Same_String is new Same (T => String);
--  error: actual for "T" must be a definite subtype
```

`(<>)` in front drops that promise:

```adasnippet
generic
   type T (<>) is private;
function Same_Any (A, B : T) return Boolean;
```

Now `String` is allowed, and in exchange the body may no longer write `Local : T;` with nothing to
initialise it from.

> [!TIP]
> If a body only ever receives values as parameters and returns them, `(<>)` costs it nothing and
> widens what can be instantiated. If it needs a working variable, it needs the definite form.
