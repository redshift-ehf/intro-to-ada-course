## Exercise: Directions, private

The Records chapter's directions, with `Ext_Angle` made private.

### What changed

```adasnippet
type Ext_Angle is private;

function To_Ext_Angle (N : Angle_Mod) return Ext_Angle;
function Angle_Of (E : Ext_Angle) return Angle_Mod;
function Direction_Of (E : Ext_Angle) return Direction;

private

   type Ext_Angle is record
      Angle_Elem     : Angle_Mod;
      Direction_Elem : Direction;
   end record;
```

This is not only about hiding. In the Records version anybody could write

```adasnippet
Bad : Ext_Angle := (45, South);
```

— an angle and a direction that flatly contradict each other, and nothing to stop it. Now
`To_Ext_Angle` is the only way to make one, and it works the direction out from the angle. The
type can no longer hold a value that makes no sense.

That is the real return on a private type: not secrecy, but an **invariant** you can actually
rely on.

### What to write

```adasnippet
function To_Ext_Angle (N : Angle_Mod) return Ext_Angle;
function Angle_Of (E : Ext_Angle) return Angle_Mod;
function Direction_Of (E : Ext_Angle) return Direction;
```

`To_Direction` and `Display` are already written. The test checks all 360 angles agree with their
own directions, which is a claim you can only make because the constructor is the only door in.

> [!NOTE]
> The unit is `Private_Directions`, since `Directions` belongs to the Records chapter.

Press **Check** when you are done.
