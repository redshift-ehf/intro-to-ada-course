with Ada.Text_IO;  use Ada.Text_IO;
with Interfaces.C; use Interfaces.C;

procedure Show_Foreign_Subprograms is

   --  Ada calling C. `Import` says the body is elsewhere, `Convention => C` says how to call
   --  it, and the names match, so nothing else is needed.
   function Fs_Twice (A : int) return int
     with Import, Convention => C;

   --  `External_Name` when the Ada name should differ from the C one -- which is usually, since
   --  a C library's names are rarely what you would have chosen.
   function Clamp (Value, Low, High : int) return int
     with Import, Convention => C, External_Name => "fs_clamp";
begin
   Put_Line ("fs_twice (21)        =" & int'Image (Fs_Twice (21)));
   Put_Line ("clamp (5, 10, 20)    =" & int'Image (Clamp (5, 10, 20)));
   Put_Line ("clamp (15, 10, 20)   =" & int'Image (Clamp (15, 10, 20)));
   Put_Line ("clamp (25, 10, 20)   =" & int'Image (Clamp (25, 10, 20)));

   --  The other direction -- C calling Ada -- uses `Export` instead, and is shown in the task
   --  description. It cannot be demonstrated *here*, because an exported subprogram must be at
   --  library level: this one is nested inside a procedure, and GNAT says so plainly --
   --  "local subprogram cannot be exported". The C Statistics exercise does it in a package,
   --  where it is legal.
end Show_Foreign_Subprograms;
