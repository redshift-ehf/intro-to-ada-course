with Ada.Text_IO;  use Ada.Text_IO;
with Interfaces.C; use Interfaces.C;

procedure Show_Multi_Language is

   --  These two live in ml_helper.c, in this same directory. `Import` says the body is
   --  elsewhere; `Convention => C` says how to call it.
   function Ml_Double (X : int) return int
     with Import, Convention => C;

   function Ml_Half (X : double) return double
     with Import, Convention => C;
begin
   Put_Line ("ml_double (21) =" & int'Image (Ml_Double (21)));
   Put_Line ("ml_half (7.0)  =" & double'Image (Ml_Half (7.0)));

   --  There is no separate build step for the C. One `gprbuild` compiled both languages and
   --  linked them together, because the project file says it may.
end Show_Multi_Language;
