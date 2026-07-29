## If, then, else

An `if` statement is the reserved word `if`, a condition, the word `then`, and a non-empty sequence
of statements. The condition must be a **Boolean** — not an integer that counts as true when it is
non-zero. Ada has no such rule, and the compiler will reject the program rather than guess.

```adasnippet
if N > 0 then
   Put_Line (" is a positive number");
end if;
```

Add alternatives with `elsif`, and a fallback with `else`:

```adasnippet
if N = 0 or N = 360 then
   Put_Line (" is due north");
elsif N in 1 .. 89 then
   Put_Line (" is in the northeast quadrant");
else
   Put_Line (" is somewhere in the west");
end if;
```

Two things here are not what C or its descendants would do.

`elsif` is one word and one construct. In C you would nest an `if` inside an `else`, and each level
would need closing. Ada's chain is flat, which is what it looks like when you read it aloud.

`end if` closes the whole statement, so there is no *dangling else* — no ambiguity about which `if`
an `else` belongs to, and no convention about braces to remember, because the language settles it.

`in 1 .. 89` is a membership test against a range. It is worth reaching for: it says what it means
more directly than `N >= 1 and N <= 89`, and it cannot be got subtly wrong.

Press **Run**, then change `N` near the top of the file and run it again.

> The original of this example reads `N` from the keyboard. Here it is a constant you edit, so that
> Run does something immediately rather than waiting for input.

---

<div class="hint">
Running this reports two warnings, both saying <code>condition is always False</code>.

They are correct. `N` is a constant, so the compiler already knows it is 45 and can see that
`N = 0 or N = 360` cannot be true. It is telling you it worked out the answer without running the
program — which is the whole business of a compiler that checks things.

Change `N` to `0` and run it again. The same line is reported, but one of the two now reads
`condition is always True`: the compiler is following along with your edit.
</div>
