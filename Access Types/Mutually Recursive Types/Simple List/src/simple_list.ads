--  A singly linked list, built out of a type that refers to itself.
--
--  An original exercise; AdaCore's Laboratories has no Access Types chapter.
package Simple_List is

   --  Incomplete first, so that Node_Acc can be declared, so that Node can use it.
   type Node;

   type Node_Acc is access Node;

   type Node is record
      Content : Natural;
      Next    : Node_Acc;
   end record;

   type List is record
      Head : Node_Acc := null;
   end record;

   --  Adds to the front, so the most recent value is the one at Head.
   procedure Push (L : in out List; Value : Natural);

   function Length (L : List) return Natural;

   function Sum (L : List) return Natural;

   function Contains (L : List; Value : Natural) return Boolean;

end Simple_List;
