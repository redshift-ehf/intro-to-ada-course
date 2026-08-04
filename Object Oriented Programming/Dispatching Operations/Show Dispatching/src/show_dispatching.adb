with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Dispatching is

   package P is
      type My_Class is tagged null record;
      procedure Foo (Self : My_Class);

      type Derived is new My_Class with record
         A : Integer := 0;
      end record;

      overriding procedure Foo (Self : Derived);
   end P;

   package body P is
      procedure Foo (Self : My_Class) is
         pragma Unreferenced (Self);
      begin
         Put_Line ("   My_Class.Foo");
      end Foo;

      procedure Foo (Self : Derived) is
      begin
         Put_Line ("   Derived.Foo, A =" & Integer'Image (Self.A));
      end Foo;
   end P;

   use P;

   O1 : constant My_Class := (null record);
   O2 : constant Derived  := (A => 12);

   O3 : constant My_Class'Class := O2;
   O4 : constant My_Class'Class := O1;
begin
   --  The type is known here, so the compiler picks the body. No tag is consulted and there is
   --  nothing to look up at run time.
   Put_Line ("Foo (O1) -- static, O1 is a My_Class:");
   Foo (O1);
   Put_Line ("Foo (O2) -- static, O2 is a Derived:");
   Foo (O2);

   --  These two are classwide, so the tag decides. Same call, two different bodies.
   Put_Line ("Foo (O3) -- dispatching, O3 holds a Derived:");
   Foo (O3);
   Put_Line ("Foo (O4) -- dispatching, O4 holds a My_Class:");
   Foo (O4);

   --  A view conversion changes which type an object is *seen* as, and with it the tag used
   --  for dispatch.
   declare
      D  : constant Derived        := (A => 99);
      As_Parent : constant My_Class := My_Class (D);
      Wide      : constant My_Class'Class := As_Parent;
   begin
      Put_Line ("after My_Class (D), dispatching on it:");
      Foo (Wide);
   end;
end Show_Dispatching;
