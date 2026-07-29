## Loops

Ada has three loop forms, and they are all the same construct with different ways of deciding when
to stop. Every one of them ends with `end loop;`.

### For loops

```adasnippet
for I in 1 .. 5 loop
   Put_Line ("Hello, World!" & Integer'Image (I));
end loop;
```

`I` is declared by the loop itself — there is no `I : Integer` anywhere, and `I` does not exist
outside the loop. Within one turn it is a **constant**: you can read it, and you cannot assign to
it. The loop advances it; your body does not.

`1 .. 5` is a range, the same kind you saw in `N in 1 .. 89`. Put `reverse` in front to go the
other way:

```adasnippet
for I in reverse 1 .. 5 loop
```

A range whose end is below its start is empty, and the loop simply runs zero times rather than
being an error or wrapping around:

```adasnippet
for I in reverse 5 .. 1 loop   --  runs zero times
```

### Bare loops

`loop` on its own repeats until something says otherwise. `exit when` is that something, and it can
sit anywhere in the body — including the middle, which is the case the other two forms cannot
express without repeating yourself.

```adasnippet
loop
   Put_Line ("Hello, World!" & Integer'Image (I));
   exit when I = 5;
   I := I + 1;
end loop;
```

Here `I` is an ordinary variable you declared and you increment, because nothing is managing it
for you.

### While loops

```adasnippet
while I <= 5 loop
   Put_Line ("Hello, World!" & Integer'Image (I));
   I := I + 1;
end loop;
```

The test happens before each turn, so a while loop can run zero times. As with `if`, the condition
must be a Boolean.

`Integer'Image (I)` turns a number into text so it can be joined with `&`. Note the leading space
it produces — that space is where a minus sign would go.

Press **Run** to see all four in order.

---

<div class="hint">
One warning appears: <code>loop range is null, loop will not execute</code>, pointing at the
<code>reverse 5 .. 1</code> loop.

That is the example working. The loop is there to show that an empty range is allowed rather than
an error, and the compiler has noticed the same thing and thought you might want to know.
</div>
