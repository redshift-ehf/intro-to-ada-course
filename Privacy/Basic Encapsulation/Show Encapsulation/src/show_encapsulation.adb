with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Encapsulation is

   --  `private` splits a package spec in two. Everything before it is the package's public face;
   --  everything after is visible only to the package's own body and to its children.
   package Greeter is

      procedure Hello;

   private

      procedure Hello2;
      --  Declared, but not part of what anyone outside can call.

   end Greeter;

   package body Greeter is

      procedure Hello is
      begin
         Put_Line ("Hello");
         --  In here, the private part is perfectly visible.
         Hello2;
      end Hello;

      procedure Hello2 is
      begin
         Put_Line ("Hello #2, reached from inside the package");
      end Hello2;

   end Greeter;

begin
   Greeter.Hello;

   --  Greeter.Hello2;
   --  ^ does not compile out here. Try it and read the error.
end Show_Encapsulation;
