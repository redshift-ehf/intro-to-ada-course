with Ada.Text_IO;  use Ada.Text_IO;
with Interfaces.C; use Interfaces.C;

procedure Show_C_Types is

   --  Interfaces.C names C's types, and they are the ones to use at the boundary. `int` is C's
   --  int, whatever width that is on this machine -- not Ada's Integer, which is a different
   --  type that merely happens to match today.
   A : constant int      := 42;
   B : constant long     := 42;
   C : constant unsigned := 42;
   D : constant double   := 42.5;

   --  `Convention => C` on a record lays it out the way a C compiler would, so it can be passed
   --  to and from C code as a struct.
   type C_Struct is record
      A : int;
      B : long;
      C : unsigned;
      D : double;
   end record
     with Convention => C;

   --  And on an enumeration, so its values number the way C's do.
   type C_Enum is (Alpha, Beta, Gamma)
     with Convention => C;

   S : constant C_Struct := (A, B, C, D);
   E : constant C_Enum := Beta;
begin
   Put_Line ("int'Size      =" & Integer'Image (int'Size)
             & ",  Integer'Size =" & Integer'Image (Integer'Size));
   Put_Line ("long'Size     =" & Integer'Image (long'Size));
   Put_Line ("unsigned'Size =" & Integer'Image (unsigned'Size));
   Put_Line ("double'Size   =" & Integer'Image (double'Size));

   Put_Line ("a C struct holds" & int'Image (S.A) & long'Image (S.B)
             & unsigned'Image (S.C) & double'Image (S.D));
   Put_Line ("a C enum value: " & C_Enum'Image (E)
             & " at position" & Integer'Image (C_Enum'Pos (E)));

   --  Without Convention => C, Ada is free to lay a record out however it likes -- pack it,
   --  reorder it, align it differently. The aspect is what makes the two agree.
end Show_C_Types;
