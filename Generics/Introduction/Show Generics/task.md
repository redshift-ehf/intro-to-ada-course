# Generics

A **generic** is a template. It is not code until you instantiate it, and then it is ordinary code
like any other.

```adasnippet
generic
   type T is private;
procedure Report (Value : T);
```

`generic` introduces the **formal parameters** — here a type — and then the thing being made
generic. Either a subprogram or a package may be generic.

## Nothing happens until you say so

```adasnippet
procedure Report_Integer is new Report (T => Integer);

Report_Integer (42);
Report (42);            --  does not compile: a generic is not callable
```

`is new` is the instantiation. It fills every formal in and produces a real procedure with a real
name, which you then call as usual.

> [!NOTE]
> **In other languages**
>
> Closest to a C++ template, and different in one way that matters: a C++ template is checked
> when it is instantiated, so an error in an unused branch surfaces at some far-away call site.
> An Ada generic is checked when it is *written*, against what its formals promise. The body
> either compiles on its own or it does not, and no instantiation can break it.
>
> That is why the formals matter so much — they are the contract the body is checked against, and
> the next lesson is entirely about choosing them.

Press **Run** to see one generic produce two procedures.
