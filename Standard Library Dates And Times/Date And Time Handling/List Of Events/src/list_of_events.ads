with Ada.Containers.Vectors;

--  The item types. A date may carry several events, so the events for one date are a vector.
package List_Of_Events is

   --  Each description is a String on the heap, so descriptions can be any length.
   type Event_Item is access String;

   package Event_Item_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Event_Item);

   subtype Event_Items is Event_Item_Vectors.Vector;

end List_Of_Events;
