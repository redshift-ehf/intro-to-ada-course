with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Tagged_Types is

   package Shapes is
      --  `tagged` adds one thing to a record: every object carries a tag saying what it really
      --  is. Everything else in this chapter follows from that.
      type Shape is tagged record
         Name : Character := '?';
      end record;

      --  Methods live outside the type, as ordinary subprograms in the same package. There is
      --  no `class { ... }` here and nothing is "inside" anything.
      procedure Describe (Self : Shape);

      --  A derived tagged type may add components, which a plain derived type cannot.
      type Circle is new Shape with record
         Radius : Float := 0.0;
      end record;

      --  `overriding` is optional and worth writing: if it is there, the compiler checks that
      --  something is actually being overridden. A misspelling then fails to compile rather
      --  than quietly adding a new operation nobody calls.
      overriding procedure Describe (Self : Circle);

      type Square is new Shape with record
         Side : Float := 0.0;
      end record;

      overriding procedure Describe (Self : Square);
   end Shapes;

   package body Shapes is
      procedure Describe (Self : Shape) is
      begin
         Put_Line ("a shape called " & Self.Name);
      end Describe;

      procedure Describe (Self : Circle) is
      begin
         Put_Line ("a circle called " & Self.Name
                   & " of radius" & Float'Image (Self.Radius));
      end Describe;

      procedure Describe (Self : Square) is
      begin
         Put_Line ("a square called " & Self.Name
                   & " of side" & Float'Image (Self.Side));
      end Describe;
   end Shapes;

   use Shapes;

   S : constant Shape  := (Name => 's');
   C : constant Circle := (Name => 'c', Radius => 2.0);
   Q : constant Square := (Name => 'q', Side => 3.0);
begin
   Describe (S);
   Describe (C);
   Describe (Q);

   --  A Circle aggregate carries its parent's components first, then its own. `(Name => 'c',
   --  Radius => 2.0)` names both, and the parent part can also be written positionally.
end Show_Tagged_Types;
