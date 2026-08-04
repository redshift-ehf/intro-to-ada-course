--  A to-do list of a size chosen when it is declared.
package Simple_Todo_List is

   --  Each item is a String on the heap, so items can be any length.
   type Todo_Item is access String;

   type Todo_Items is array (Positive range <>) of Todo_Item;

   type Todo_List (Max : Positive) is record
      Items : Todo_Items (1 .. Max);
      Last  : Natural := 0;
   end record;

   --  Prints "ERROR: list is full!" and adds nothing when there is no room.
   procedure Add (Todos : in out Todo_List; Item : String);

   --  Prints "TO-DO LIST" and then one item per line.
   procedure Display (Todos : Todo_List);

end Simple_Todo_List;
