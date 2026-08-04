with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Recursive_Types is
   --  An incomplete type declaration. It says Node exists; what is in it comes later. That is
   --  all Node_Acc needs, and Node can then use Node_Acc -- which is how two types refer to
   --  each other without either having to be written first.
   type Node;

   type Node_Acc is access Node;

   type Node is record
      Content    : Natural;
      Prev, Next : Node_Acc;
   end record;

   First  : constant Node_Acc := new Node'(Content => 1, Prev => null, Next => null);
   Second : constant Node_Acc := new Node'(Content => 2, Prev => First, Next => null);
begin
   --  First is a *constant* Node_Acc, and this is still allowed: the access value does not
   --  change, only the object it designates. Constant access, mutable target.
   First.Next := Second;

   Put_Line ("first is" & Natural'Image (First.Content));
   Put_Line ("its next is" & Natural'Image (First.Next.Content));
   Put_Line ("whose prev is" & Natural'Image (Second.Prev.Content));
   Put_Line ("and that one's next is null: " & Boolean'Image (Second.Next = null));
end Show_Recursive_Types;
