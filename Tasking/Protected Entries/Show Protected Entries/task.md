# Entries

A protected **entry** is a procedure with a condition on it:

```adasnippet
entry Get (V : out Integer) when Is_Set is
begin
   V := Local;
   Is_Set := False;
end Get;
```

The `when` is a **barrier**. A task calling `Get` while `Is_Set` is `False` does not fail and does
not spin — it sleeps, and is woken when the barrier becomes true.

Barriers are re-evaluated when a protected procedure or entry finishes. So `Set` making `Is_Set`
true is what releases the waiting caller, without `Set` knowing anybody was waiting.

## What this replaces

Everything you would otherwise write by hand: a flag, a loop that polls it, a sleep to stop the
polling burning a core, and a race between checking the flag and acting on it. The barrier has
none of those parts and none of their bugs.

> [!NOTE]
> The barrier may only mention the protected object's own private data. It cannot call a function
> or read something outside — which is what makes "re-evaluate every barrier on the way out"
> cheap enough to be automatic.

> [!TIP]
> This is the shape of every bounded buffer, queue and semaphore you will write:
> `entry Push ... when not Full`, `entry Pop ... when not Empty`. The Protected Queue exercise is
> exactly that, and needs no delays anywhere because the barriers do all the waiting.

Press **Run**: main asks for the value before anything has set it, and simply waits.
