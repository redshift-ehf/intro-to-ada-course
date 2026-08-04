with Ada.Text_IO; use Ada.Text_IO;

package body Containers_Simple_Todo_List is

   procedure Add (Todos : in out Todo_List; Item : String) is
   begin
      --  new String'(Item) copies the string onto the heap and yields the access value. Append
      --  then takes it, and grows the vector by itself.
      Todos.Append (new String'(Item));
   end Add;

   procedure Display (Todos : Todo_List) is
   begin
      Put_Line ("TO-DO LIST");
      for I of Todos loop
         Put_Line (I.all);
      end loop;
   end Display;

end Containers_Simple_Todo_List;
