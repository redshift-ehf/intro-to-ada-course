with Ada.Containers.Vectors;

--  The to-do list from More About Records, rewritten over a vector. Compare the two specs: this
--  one has no Max, no Items array and no Last, because the vector keeps all three.
package Containers_Simple_Todo_List is

   --  Each item is a String on the heap, so items can be any length.
   type Todo_Item is access String;

   package Todo_Item_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Natural,
      Element_Type => Todo_Item);

   subtype Todo_List is Todo_Item_Vectors.Vector;

   --  Adds one item. There is no full list to report, so nothing can go wrong.
   procedure Add (Todos : in out Todo_List; Item : String);

   --  Prints "TO-DO LIST" and then one item per line.
   procedure Display (Todos : Todo_List);

end Containers_Simple_Todo_List;
