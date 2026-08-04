with Ada.Text_IO;  use Ada.Text_IO;
with Interfaces.C; use Interfaces.C;

procedure Show_Foreign_Variables is

   function Fv_My_Func (A : int) return int
     with Import, Convention => C;

   --  A *variable* can be imported as readily as a subprogram. This is C's fv_call_count, not a
   --  copy of it: reading it here reads the same storage the C code writes.
   Fv_Call_Count : int
     with Import, Convention => C;

   --  And the other direction. This one lives here, and fv_helper.c declares it extern.
   Fv_From_Ada : int := 0
     with Export, Convention => C;

   procedure Fv_Bump_Ada
     with Import, Convention => C;

   V : int;
begin
   V := Fv_My_Func (1);
   V := Fv_My_Func (2);
   V := Fv_My_Func (3);

   Put_Line ("last result was" & int'Image (V));
   Put_Line ("and C says it was called" & int'Image (Fv_Call_Count) & " times");

   Put_Line ("Ada's own variable starts at" & int'Image (Fv_From_Ada));
   Fv_Bump_Ada;
   Fv_Bump_Ada;
   Put_Line ("after C bumped it twice, it is" & int'Image (Fv_From_Ada));

   --  Neither side owns a copy. There is one variable, and two names for it.
end Show_Foreign_Variables;
