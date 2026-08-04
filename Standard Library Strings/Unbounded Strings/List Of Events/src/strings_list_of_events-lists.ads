with Ada.Calendar; use Ada.Calendar;
with Ada.Containers.Ordered_Maps;

--  Identical to the version in Dates & Times. Nothing here knows what an Event_Item is made of.
package Strings_List_Of_Events.Lists is

   type Event_List is tagged private;

   procedure Add (Events     : in out Event_List;
                  Event_Time :        Time;
                  Event      :        String);

   procedure Display (Events : Event_List);

private

   package Event_Time_Maps is new Ada.Containers.Ordered_Maps
     (Key_Type     => Time,
      Element_Type => Event_Items,
      "<"          => Ada.Calendar."<",
      "="          => Event_Item_Vectors."=");

   type Event_List is new Event_Time_Maps.Map with null record;

end Strings_List_Of_Events.Lists;
