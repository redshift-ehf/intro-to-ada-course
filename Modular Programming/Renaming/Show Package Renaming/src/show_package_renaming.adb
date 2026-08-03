with Ada.Text_IO;
with Week;

procedure Show_Package_Renaming is

   --  A package can be renamed too, which is how a long hierarchical name becomes short enough to
   --  use unqualified without a blanket `use`.
   package IO renames Ada.Text_IO;

   --  And so can something inside one.
   Start_Of_Week : String renames Week.Mon;

begin
   IO.Put_Line ("The week starts on " & Start_Of_Week);
end Show_Package_Renaming;
