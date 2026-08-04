with Ada.Containers.Vectors;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

--  The list of events from the last chapter, with one line changed.
package Strings_List_Of_Events is

   --  It was `type Event_Item is access String;`. An Unbounded_String holds a string of any
   --  length too, and holds it as a value -- so there is no `new` and no `.all` anywhere below.
   subtype Event_Item is Unbounded_String;

   package Event_Item_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Event_Item);

   subtype Event_Items is Event_Item_Vectors.Vector;

end Strings_List_Of_Events;
