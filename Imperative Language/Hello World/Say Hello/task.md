## Exercise: Hello World

**Goal**: create a "Hello World!" application.

**Steps**:

1. Complete the `Say_Hello` procedure.

**Requirements**:

1. The application must display the message `Hello World!`.

Press **Check** when you think you have it. The check compiles your procedure and runs it, comparing
what it printed against what was asked for — so the message has to match exactly, capital `W` and
exclamation mark included.

Before you write anything, running this prints two warnings:

    warning: no entities of "Ada.Text_IO" are referenced
    warning: use clause for package "Text_IO" has no effect

Nothing is broken. This course compiles with `-gnatwa`, which asks GNAT to report everything it
notices, and it has noticed that the `use` clause on line 1 is not yet earning its place. Both go
away the moment you call something from the package. Ada's warnings are worth reading rather than
clearing away: most of them are the compiler telling you something you wrote does not do what it
looks like it does.

<div class="hint">
You saw the shape of this in the previous task. The one difference: that example wrote
<code>Ada.Text_IO.Put_Line</code> in full, while this file already has
<code>use Ada.Text_IO;</code> at the top — which makes <code>Put_Line</code> available unqualified.
</div>

<div class="hint">
<code>Put_Line ("Hello World!");</code>

<code>Put_Line</code> writes its argument and then a line break. <code>Put</code> is the same without
the break; either will pass, because the check ignores how the output ends.
</div>
