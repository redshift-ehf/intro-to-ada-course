--  A list of anything, over storage the instantiator owns.
generic
   type Item is private;
   type Items is array (Positive range <>) of Item;

   --  A formal object of mode `in`: a constant for the life of the instance.
   Name : String;

   --  Formal objects of mode `in out`: the instance writes through them. The array and its
   --  count belong to whoever instantiated this, not to the package.
   List_Array : in out Items;
   Last       : in out Natural;

   with procedure Put (I : Item);
package Generic_List is

   procedure Init;

   --  Status is False when there was no room, and nothing is added.
   procedure Add (I : Item; Status : out Boolean);

   procedure Display;

end Generic_List;
