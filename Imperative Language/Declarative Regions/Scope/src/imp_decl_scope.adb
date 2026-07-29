with Ada.Text_IO; use Ada.Text_IO;

procedure Imp_Decl_Scope is
   --  Everything between `is` and `begin` is the declarative region.
   X : Integer;

   procedure Nested is
   begin
      Put_Line ("Hello from a procedure declared inside another one");
   end Nested;

begin
   X := 0;
   Put_Line ("The initial value of X is " & Integer'Image (X));

   Put_Line ("Performing operation on X...");
   X := X + 1;

   Put_Line ("The value of X now is " & Integer'Image (X));

   Nested;

   --  A block statement opens a declarative region in the middle of the statements.
   declare
      Person : constant String := "Ada";
   begin
      Put_Line ("Hi " & Person & "!");
   end;

   --  Person does not exist out here. Uncomment the next line to watch the compiler say so.
   --  Put_Line (Person);
end Imp_Decl_Scope;
