--  `with` makes a package available. `use` makes its contents visible without qualifying them.
with Ada.Text_IO; use Ada.Text_IO;
with Week;

procedure Show_Week is
begin
   --  Qualified: the package name, a dot, the thing.
   Put_Line ("First day of the week is " & Week.Mon);

   declare
      --  `use` inside a block, so the visibility lasts exactly as long as it is wanted.
      use Week;
   begin
      Put_Line ("Last day of the week is " & Sun);
   end;

   --  Outside the block, Sun is out of scope again and this must be qualified once more.
   Put_Line ("...and midweek is " & Week.Wed);
end Show_Week;
