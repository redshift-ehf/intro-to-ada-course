with Ada.Text_IO;  use Ada.Text_IO;
with Interfaces.C; use Interfaces.C;

procedure Show_Bindings is

   --  What `gcc -c -fdump-ada-spec -C bind_helper.h` would have written, transcribed here
   --  because a generated file is a build artefact and this course keeps none.
   --
   --  A generator's output looks like this: names exactly as C spelled them, `aliased` on
   --  variables, an Import for each, and pragma Style_Checks (Off) at the top because none of
   --  it obeys Ada's naming conventions.

   Bind_Scale : aliased int
     with Import, Convention => C, External_Name => "bind_scale";

   function Bind_Add (Arg1 : int; Arg2 : int) return int
     with Import, Convention => C, External_Name => "bind_add";

   --  Adapting the binding: a thin Ada layer over the generated one, giving the library Ada
   --  names, Ada types and Ada habits. This is the part worth writing by hand, and the part a
   --  generator cannot do for you.
   function Sum (Left, Right : Integer) return Integer is
     (Integer (Bind_Add (int (Left), int (Right))));

   procedure Set_Scale (To : Integer) is
   begin
      Bind_Scale := int (To);
   end Set_Scale;
begin
   Put_Line ("straight through the binding: bind_add (2, 3) ="
             & int'Image (Bind_Add (2, 3)));

   Put_Line ("through the adapted layer:    Sum (2, 3) ="
             & Integer'Image (Sum (2, 3)));

   Set_Scale (10);
   Put_Line ("after Set_Scale (10):         Sum (2, 3) ="
             & Integer'Image (Sum (2, 3)));
end Show_Bindings;
