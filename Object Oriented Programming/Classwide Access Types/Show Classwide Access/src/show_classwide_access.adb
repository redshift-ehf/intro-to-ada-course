with Ada.Text_IO; use Ada.Text_IO;
with Ada.Tags;    use Ada.Tags;

procedure Show_Classwide_Access is

   package P is
      type T is tagged record
         E : Integer := 0;
      end record;

      --  Access to the *classwide* type. An access value is one size whatever it designates,
      --  which is what makes this the way to hold a mixed collection.
      type T_Class is access T'Class;

      procedure Init (A : in out T);
      procedure Show (Self : T);

      type T_New is new T with null record;

      overriding procedure Show (Self : T_New);
   end P;

   package body P is
      procedure Init (A : in out T) is
      begin
         A.E := 0;
      end Init;

      procedure Show (Self : T) is
         pragma Unreferenced (Self);
      begin
         Put_Line ("   using type " & Expanded_Name (T'Tag));
      end Show;

      procedure Show (Self : T_New) is
         pragma Unreferenced (Self);
      begin
         Put_Line ("   using type " & Expanded_Name (T_New'Tag));
      end Show;
   end P;

   use P;

   --  `array (1 .. 2) of T'Class` does not compile: a classwide type is indefinite, so the
   --  compiler cannot say how big an element is. An array of accesses to it can.
   Items : array (1 .. 2) of T_Class;
begin
   Items (1) := new T;
   Items (2) := new T_New;

   for I in Items'Range loop
      Put_Line ("element #" & Integer'Image (I));

      --  Both calls dispatch: what Items (I) designates is classwide, so the tag decides.
      --  Init was never overridden, so both reach T's body; Show was, so they differ.
      Items (I).Init;
      Items (I).Show;
   end loop;
end Show_Classwide_Access;
