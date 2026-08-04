with Ada.Text_IO; use Ada.Text_IO;

package body Simple_Todo_List is

   procedure Add (Todos : in out Todo_List; Item : String) is
   begin
      if Todos.Last >= Todos.Max then
         Put_Line ("ERROR: list is full!");
      else
         Todos.Last := Todos.Last + 1;
         --  A new String of exactly the right length, allocated from the value.
         Todos.Items (Todos.Last) := new String'(Item);
      end if;
   end Add;

   procedure Display (Todos : Todo_List) is
   begin
      Put_Line ("TO-DO LIST");
      for I in 1 .. Todos.Last loop
         Put_Line (Todos.Items (I).all);
      end loop;
   end Display;

end Simple_Todo_List;
