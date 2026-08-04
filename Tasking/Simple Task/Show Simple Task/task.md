# Simple task

A **task** is a thread of control that runs alongside everything else. It is declared with
`task`, and its body says what it does:

```adasnippet
task T;

task body T is
begin
   Put_Line ("In task T");
end T;
```

Nothing starts it. A task begins running when its **master** — the construct it is declared in —
reaches its `begin`, and there is no handle to hold and no start call to remember.

## Everything is a task

The main subprogram is one too: the *environment task*. So a program with `T` and `T2` declared
in it has three tasks running, and `T` and `T2` are subtasks of the main one because that is
where they were declared.

> [!NOTE]
> **In other languages**
>
> A task is roughly a thread — but a declared one, with its lifetime tied to a scope rather than
> to a handle you have to remember to join. Most of what makes threads difficult elsewhere is
> handled by that, and by the next few lessons.

## Order is not decided here

Press **Run** twice. The three lines may come out in a different order, and neither run is more
correct than the other — nothing in this program says which should go first.

Everything that follows is about saying so when it matters: waiting for a task to finish,
meeting one at an agreed point, or sharing data with one safely.
