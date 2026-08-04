## Exercise: Directions

Write a package that turns an angle into a compass direction.

### The types

These are given:

```adasnippet
type Angle_Mod is mod 360;

type Direction is
  (North, Northeast, East, Southeast, South, Southwest, West, Northwest);

type Ext_Angle is record
   Angle_Elem     : Angle_Mod;
   Direction_Elem : Direction;
end record;
```

`Angle_Mod` is modular because angles are: 360 degrees is 0 degrees, and a modular type says that
rather than leaving you to remember it.

### What to write

```adasnippet
function To_Direction (N : Angle_Mod) return Direction;
function To_Ext_Angle (N : Angle_Mod) return Ext_Angle;
procedure Display (N : Ext_Angle);
```

`To_Direction` maps an angle to its direction. The four cardinal points are exactly one angle each,
and everything between them belongs to the diagonal:

| Angle | Direction |
|---|---|
| 0 | North |
| 1 .. 89 | Northeast |
| 90 | East |
| 91 .. 179 | Southeast |
| 180 | South |
| 181 .. 269 | Southwest |
| 270 | West |
| 271 .. 359 | Northwest |

`To_Ext_Angle` builds the record: the angle it was given, and the direction that angle falls in.

`Display` prints one line, in exactly this shape:

```
Angle:  0 => NORTH.
Angle:  45 => NORTHEAST.
Angle:  270 => WEST.
```

Two spaces after the colon is not a mistake — `'Image` puts its own space in front of a
non-negative number, so `"Angle: "` and the image together give you both.

> [!NOTE]
> `Angle_Mod` runs 0 .. 359 and the table above covers every one of those, so your `case` needs no
> `others` branch. Leave it out: then if you ever miss a value the compiler tells you, which an
> `others` branch would have quietly swallowed.

Press **Check** when you are done.
