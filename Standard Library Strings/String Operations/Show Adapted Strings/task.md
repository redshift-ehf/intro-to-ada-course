# Changing a fixed-length string

Four operations, each available twice:

| | |
|---|---|
| `Insert` | put a substring in |
| `Overwrite` | write a substring over what is there |
| `Delete` | take a substring out |
| `Trim` | remove whitespace from the ends |

**The function returns a new string; the procedure modifies one in place.** That is not two ways
of saying the same thing, because a `String` cannot change length.

## The consequence

```adasnippet
S_Ins : constant String := Insert (Source, Before, New_Item & " ");
```

The function's result is as long as the answer needs to be — inserting nine characters into eleven
gives twenty-one.

```adasnippet
Insert (S_Ins_In, Before, New_Item, Right);
```

The procedure's argument is still eleven characters, so it must be told what to do with what will
not fit. `Right` drops it off the right-hand end:

```
Insert:               'Hello Beautiful World'
Insert    (in-place): 'Hello Beaut'
```

Without a truncation argument, the procedure raises `Ada.Strings.Length_Error` instead.

## Delete does not shrink

```
Delete:               'Hello'
Delete    (in-place): 'Hello      '
```

The in-place version blanks the range rather than closing the gap — again, the length cannot
change. `Trim (…, Right)` on the function's result is what removes the trailing space.

> [!NOTE]
> This is the whole argument of the next lesson. Every awkwardness above comes from `String` being
> an array, and bounded and unbounded strings are not arrays.

> [!TIP]
> Prefer the function forms while you are working with `String`. They compose, they cannot
> truncate silently, and the compiler works out the lengths.
