## Exercise: Greetings

**Goal**: greet someone by name.

**Steps**:

1. Complete the `Imp_Hello_Greetings` procedure.

**Requirements**:

1. Given the name `John`, the procedure must display `Hello John!`.

This one is different from the last in a way worth noticing: the procedure takes an argument.

```adasnippet
procedure Imp_Hello_Greetings (Name : String) is
```

`Name : String` says this procedure needs a string to do its job, and inside the body `Name` stands
for whatever the caller passed. Note what is *not* there: no length. Ada strings carry their own
bounds, so `Name` is exactly as long as the string handed in, and the same procedure works for
`John` and for `Ada Lovelace` without you doing anything about it.

Join strings together with `&`:

```adasnippet
Put_Line ("Two" & " " & "words");
```

Because this procedure takes an argument it is no longer a program you can Run — a main has to be
callable with nothing. Use **Check**, which calls it for you with several different names. That is
the reason for the change: a name read from the command line could only ever test one, and a
solution that ignores `Name` and prints `Hello John!` outright would pass.

The two warnings about `Ada.Text_IO` from the previous exercise show up here too, for the same
reason and with the same cure.

One of them can outlast your answer. Writing `Ada.Text_IO.Put_Line` in full — the way the very
first task did, because that file had no `use` clause — works perfectly and passes the check, but
leaves the `use` clause on line 1 with nothing to do, and GNAT says so: `use clause for package
"Text_IO" has no effect`. It is not complaining about your code. It is pointing at a line that is
no longer earning its place, and either using `Put_Line` unqualified or deleting the `use` clause
settles it.

<div class="hint">
The pieces are the greeting, the name, and the exclamation mark — three strings joined with `&`,
handed to `Put_Line`.
</div>

<div class="hint">
<code>Put_Line ("Hello " & Name & "!");</code>

Mind the space after <code>Hello</code>. `&` joins exactly what it is given and adds nothing, so
without it you get <code>HelloJohn!</code>.
</div>
