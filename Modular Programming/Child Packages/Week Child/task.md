# Child packages

A package can have children. `Week.Child` is a separate compilation unit that sits *inside* its
parent's declarative region — it sees everything the parent declares, including things the parent's
body keeps private from everyone else.

```adasnippet
package Week.Child is
   function Get_First_Of_Week return String;
end Week.Child;
```

GNAT names the files with a hyphen: `Week.Child` is `week-child.ads` and `week-child.adb`. You will
see that again in this chapter's Operations exercise.

Children are how a large interface gets divided without being flattened: `Ada.Text_IO` is a child of
`Ada`, and `Ada.Text_IO.Unbounded_IO` is a child of that.

> [!NOTE]
> The example here is a standalone package that `with`s `Week`, rather than a true child, because
> its parent lives in another task and a child must be compiled alongside its parent. The mechanism
> it shows — one package building on another's declarations — is the same. The Operations exercise
> uses a real child.
