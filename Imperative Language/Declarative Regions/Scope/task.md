## Declarative regions

Ada keeps declarations and statements apart. Everything between `is` and `begin` is the
**declarative region**; everything between `begin` and `end` is statements. You have been looking at
one since the first task without it being named.

```adasnippet
procedure Imp_Decl_Scope is
   X : Integer;          --  declarations go here
begin
   X := 0;               --  statements go here
end Imp_Decl_Scope;
```

There is no mixing the two, which means that reading any subprogram tells you what it works with
before it starts working. It also means a variable cannot appear halfway down a long procedure
where you will not notice it.

Subprograms are declarations too, so one can be declared inside another:

```adasnippet
procedure Imp_Decl_Scope is
   procedure Nested is
   begin
      Put_Line ("Hello");
   end Nested;
begin
   Nested;
end Imp_Decl_Scope;
```

`Nested` exists only inside its parent. Nothing outside can call it, so nothing outside needs to
know it is there — a helper can stay exactly as private as it deserves.

When you do want a variable partway through, open a new region with a `declare` block:

```adasnippet
declare
   Person : constant String := "Ada";
begin
   Put_Line ("Hi " & Person & "!");
end;
--  Person does not exist here.
```

The block is a statement that contains its own declarative region, so it fits wherever a statement
does — inside a loop, inside an `if`. `Person` lives exactly as long as the block and no longer.

Press **Run**. Then uncomment the last line, which uses `Person` outside its block, and run again.
The compiler answers `"Person" is undefined` — not a warning, not something noticed at run time,
but a refusal to build a program that reaches for a name that is not there.
