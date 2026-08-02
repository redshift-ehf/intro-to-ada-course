## Exercise: Positive Or Negative

**Goal**: say whether a number is positive, negative, or zero.

**Steps**:

1. Complete the `Classify` procedure.

**Requirements**:

1. For a number greater than zero, display `Positive`.
2. For a number less than zero, display `Negative`.
3. For zero, display `Zero`.

Three outcomes, so a bare `if`/`else` is one short — you need an `elsif` in between, or a nested
`if` inside the `else`. Prefer the `elsif`.

The check tries five numbers: a large positive, a large negative, zero, and then `1` and `-1`. The
last two are there on purpose. Zero is where this kind of code goes wrong, and it goes wrong at the
boundary rather than in the middle, so a solution that says `X >= 0` for positive passes three of
the five cases and fails the one that matters.

<div class="hint">
The shape is the one from the previous task:

<code>if</code> … <code>then</code> … <code>elsif</code> … <code>then</code> … <code>else</code> …
<code>end if;</code>

with `X > 0` and `X < 0` as the two conditions. Anything that is neither is zero, so the `else`
needs no test of its own.
</div>

<div class="hint">
<code>if X > 0 then</code><br/>
<code>&nbsp;&nbsp;&nbsp;Put_Line ("Positive");</code><br/>
<code>elsif X < 0 then</code><br/>
<code>&nbsp;&nbsp;&nbsp;Put_Line ("Negative");</code><br/>
<code>else</code><br/>
<code>&nbsp;&nbsp;&nbsp;Put_Line ("Zero");</code><br/>
<code>end if;</code>
</div>
