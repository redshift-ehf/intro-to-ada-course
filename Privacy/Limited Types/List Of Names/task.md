## Exercise: List of Names, limited

The Arrays chapter's list, with `Person` and `People` made **limited private**.

### What changed

```adasnippet
type People is limited private;

function Count (P : People) return Natural;

private

   type Person is limited record
      Name : Name_Type := (others => ' ');
      Age  : Age_Type  := 0;
   end record;

   type People_Array is array (Positive range <>) of Person;

   type People is limited record
      People_A   : People_Array (1 .. Max_People);
      Last_Valid : Natural := 0;
   end record;
```

`People_Array` has moved behind `private` too — it was only ever an implementation detail, and
leaving it public would have been a promise about how the list is stored.

`Last_Valid` is no longer reachable from outside, so `Count` replaces it.

### What to write

```adasnippet
procedure Add (P : in out People; Name : String);
function Count (P : People) return Natural;
```

`Get`, `Update`, `Display`, `Reset`, `Padded` and `Trimmed` are all written for you.

> [!TIP]
> **`Person` is limited too**, so you cannot write
>
> ```adasnippet
> P.People_A (P.Last_Valid) := (Name => Padded (Name), Age => 0);
> ```
>
> as the Arrays version did — that is an assignment of a limited record. Set the two components
> separately instead. `limited` stops the *type* being copied; its components are ordinary
> `String` and `Natural`, and those assign as they always did.

> [!NOTE]
> The unit is `Private_List_Of_Names`, since `List_Of_Names` belongs to the Arrays chapter.

Press **Check** when you are done.
