# Character types

A character literal is an enumeration literal. That one fact is the whole lesson.

It means `Character` is not built into the language as a special case — it is an enumeration type
declared in `Standard`, with 256 values. And it means you can declare your own:

```adasnippet
type My_Char is ('a', 'b', 'c');
```

`My_Char` has exactly three values. Not "characters, restricted to three" — three, the way
`(Red, Green, Blue)` has three.

## What follows from that

```adasnippet
C : Character;
M : My_Char;

C := '?';                  --  fine
M := 'a';                  --  fine

C := 65;                   --  no: 65 is not a Character
C := Character'Val (65);   --  yes: the value at position 65, which is 'A'

M := C;                    --  no: C is a Character, M is a My_Char
M := 'd';                  --  no: 'd' is not a value of My_Char
```

Every one of those is the enumeration rule you already know, applied to characters. `'Val` and
`'Pos` work because `Character` is an enumeration; the two assignments fail because two
enumeration types are two types, however much their literals look alike.

> [!TIP]
> Try each of the three rejected lines in the file and press **Run**. Three different errors, and
> each one names the rule it is enforcing.

> [!NOTE]
> `My_Char'Image ('a')` gives `'a'`, quotes included — the image of an enumeration value is how
> that value is written, and a character literal is written with quotes.
