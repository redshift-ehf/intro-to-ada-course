with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

procedure Show_Deallocation is
   type Int_Acc is access Integer;

   --  Freeing is deliberately awkward to reach. There is no `delete`: you instantiate this
   --  yourself, per access type, and the name says plainly what it is not checking for you.
   procedure Free is new Ada.Unchecked_Deallocation (Integer, Int_Acc);

   A : Int_Acc := new Integer'(42);
begin
   Put_Line ("A designates" & Integer'Image (A.all));
   Put_Line ("A is null: " & Boolean'Image (A = null));

   Free (A);

   --  Free sets its argument to null, which is the one guarantee it does make. Any *other*
   --  access value that designated the same object is now dangling, and nothing detects that.
   Put_Line ("after Free, A is null: " & Boolean'Image (A = null));
end Show_Deallocation;
