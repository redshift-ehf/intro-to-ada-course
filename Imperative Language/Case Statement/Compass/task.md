## Case statements

A long `elsif` chain that keeps testing the same thing is better written as a `case`:

```adasnippet
case N is
   when 0 | 360   => Put_Line (" is due north");
   when 1 .. 89   => Put_Line (" is in the northeast quadrant");
   when 90        => Put_Line (" is due east");
   when others    => Put_Line (" is not a compass bearing");
end case;
```

Each `when` takes single values, ranges with `..`, alternatives separated by `|`, or `others`.

Two rules make this stricter than the `switch` you may know, and both are worth having.

**Every possible value must be covered, exactly once.** `N` is an `Integer`, so its range runs far
past 360 in both directions — hence `others`. Leave a gap and the program does not compile. That
sounds like bureaucracy until you change a type later and the compiler lists every `case` that no
longer covers it, instead of your program quietly taking a branch nobody thought about.

**Execution does not fall through.** When a branch finishes, the `case` is over. Ada has no `break`
because there is nothing to break out of — and so no bug from forgetting one.

Press **Run**, then change `N` and run it again.

> The original of this example wraps the `case` in a loop reading numbers from the keyboard, and
> exits on anything out of range. Here `N` is a constant you edit, so Run does something
> immediately.
