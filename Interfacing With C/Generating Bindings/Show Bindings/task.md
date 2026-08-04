# Generating bindings

Writing `Import` declarations by hand for a large C library is tedious and error-prone. GCC will
do it for you:

```
gcc -c -fdump-ada-spec -C ./test.h
```

Given a header, that writes an Ada spec — `test_h.ads` — with an `Import` for every function and
variable in it.

## What a generated binding looks like

```adasnippet
pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package test_h is
   func_cnt : aliased int;
   pragma Import (C, func_cnt, "func_cnt");

   function my_func (arg1 : int) return int;
   pragma Import (C, my_func, "my_func");
end test_h;
```

Names exactly as C spelled them, `aliased` on the variables, an `Import` for each, and
`Style_Checks (Off)` because none of it follows Ada's naming conventions. It is *correct* and it
is not pleasant to use.

## Adapting the binding

So the generated spec is the bottom layer, not the interface. Above it goes a thin Ada one:

```adasnippet
function Sum (Left, Right : Integer) return Integer is
  (Integer (Bind_Add (int (Left), int (Right))));
```

Ada names, Ada types, Ada habits — and the `int`s stop at that boundary instead of spreading
through the program. This is the part worth writing by hand, and the part a generator cannot do
for you: it knows the header's shape, not what the library *means*.

> [!NOTE]
> This example transcribes what the generator would have written rather than shipping its output,
> because a generated file is a build artefact and this course keeps none. Run the command on a
> real header and compare.
