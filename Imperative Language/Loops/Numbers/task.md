## Exercise: Numbers

**Goal**: display every integer between two numbers.

**Steps**:

1. Complete the `Imp_Loops_Numbers` procedure.

**Requirements**:

1. Display every integer from the smaller of the two arguments to the larger, one per line.
2. It must count upwards whichever order the arguments arrive in — `(1, 5)` and `(5, 1)` produce
   the same output.

`First` and `Last` are already declared for you, using the attributes `Integer'Min` and
`Integer'Max`. That is the second requirement handled: whatever order the arguments came in,
`First` is the smaller. Your loop runs from one to the other.

The output uses `Integer'Image`, so each line begins with the space where a minus sign would go —
` 1` rather than `1`. The check expects exactly that, and the range that crosses zero shows why it
is there.

<div class="hint">
Two constants are declared and the compiler is warning you that neither is used. That is the
warning being useful: it is naming the two things you were given and have not picked up yet.
</div>

<div class="hint">
A `for` loop over the range `First .. Last`, with `Put_Line (Integer'Image (I));` inside it.

The reason for `First` and `Last` rather than `A` and `B`: `for I in 5 .. 1` is an empty range, so
looping over `A .. B` directly would print nothing at all when the arguments arrive the wrong way
round — and print nothing *silently*, which is the worst kind of wrong.
</div>

<div class="hint">
<code>for I in First .. Last loop</code><br/>
<code>&nbsp;&nbsp;&nbsp;Put_Line (Integer'Image (I));</code><br/>
<code>end loop;</code>
</div>
