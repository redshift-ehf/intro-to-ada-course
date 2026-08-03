# Modular Programming

So far every program has been a single file. Ada's tool for structuring larger ones is the
**package**: a named group of declarations that can be compiled on its own and used from anywhere.

A package has two parts, and they live in two files:

| Part | File | Contains |
|---|---|---|
| Specification | `week.ads` | What exists — the promise |
| Body | `week.adb` | How it works — the delivery |

```adasnippet
package Week is

   Mon : constant String := "Monday";
   Sun : constant String := "Sunday";

end Week;
```

This package declares only constants. There is nothing to implement, so it needs **no body at
all** — a spec with no subprograms is a complete package.

> [!NOTE]
> The file names are not a convention you may ignore. GNAT finds a unit by its file name: package
> `Week` must be in `week.ads`, lowercased. You met the same rule for procedures.
