with Ada.Text_IO; use Ada.Text_IO;
with Ada.Tags;    use Ada.Tags;

procedure Show_Classwide_Types is

   package P is
      type My_Class is tagged record
         E : Integer := 0;
      end record;

      procedure Foo (Self : My_Class);

      type Derived is new My_Class with record
         A : Integer := 0;
      end record;

      overriding procedure Foo (Self : Derived);
   end P;

   package body P is
      procedure Foo (Self : My_Class) is
      begin
         Put_Line ("In My_Class.Foo, E =" & Integer'Image (Self.E));
      end Foo;

      procedure Foo (Self : Derived) is
      begin
         Put_Line ("In Derived.Foo, A =" & Integer'Image (Self.A));
      end Foo;
   end P;

   use P;

   O1 : constant My_Class := (E => 1);
   O2 : constant Derived  := (E => 2, A => 12);

   --  `My_Class'Class` is the *classwide* type: every type descended from My_Class, and
   --  My_Class itself. A Derived fits here; a plain My_Class variable would not take one.
   O3 : constant My_Class'Class := O2;
   O4 : constant My_Class'Class := O1;
begin
   --  'Tag is the tag the object is carrying, and Ada.Tags reads it back as text. This is the
   --  runtime type information a tagged type has and a plain record does not.
   Put_Line ("O3 holds a " & Expanded_Name (O3'Tag));
   Put_Line ("O4 holds a " & Expanded_Name (O4'Tag));

   Foo (O3);
   Foo (O4);

   --  A classwide type is *indefinite* -- its size is not known until it holds something. So it
   --  must be initialised where it is declared, and cannot be a record component. The next
   --  lesson but one shows what to use instead when you need a collection of them.
end Show_Classwide_Types;
