# Task types

`task type` declares a **kind** of task. Nothing runs until an object of it is declared:

```adasnippet
task type Worker (ID : Positive) is
   entry Report;
end Worker;

W1 : Worker (1);
W2 : Worker (2);
```

Same relationship as between a record type and a record. And a task type takes **discriminants**
just as a record does, which is how each instance knows which one it is.

## Arrays of tasks

```adasnippet
type Team is array (1 .. 3) of Worker (9);
Crew : Team;
```

Three more tasks, all started when `Crew` is elaborated, all waited for when its scope ends. That
is a worker pool in two lines, with no pool to manage.

> [!NOTE]
> Every instance is a separate task with its own stack and its own copy of everything the body
> declares. Two `Worker`s share nothing unless you deliberately give them something shared — a
> protected object, say.

> [!TIP]
> The discriminant is fixed for the task's life, like a record's. If a task needs a value that
> can change, pass it through an entry instead.

Press **Run**: five workers report, in the order they are asked to, because each reply is written
inside its rendezvous.
