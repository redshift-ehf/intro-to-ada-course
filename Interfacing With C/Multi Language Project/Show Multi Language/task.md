# Multi-language project

One line in the project file, and gprbuild compiles C beside Ada:

```adasnippet
project Course is
   for Languages use ("Ada", "C");
   ...
```

That is the whole build story. `ml_helper.c` sits in this task's `src/` directory next to the
Ada, and one `gprbuild` compiles both and links them together. No makefile, no separate step, no
linker flags.

## What this course needs

A C compiler, which you already have: **GNAT is GCC**, and the Alire toolchain the README
recommends ships `gcc` beside `gnatmake`. Nothing else in the course has a C source, so this
costs the other chapters nothing.

> [!NOTE]
> `scripts/check_course.py` knows not to build a `.c` file on its own. Naming one on gprbuild's
> command line makes it a *main*, and the link then fails for want of a `_main` — measured. C
> sources are compiled as part of whatever Ada unit imports them.

Press **Run**: two C functions, called from Ada, with nothing between them but a declaration.
