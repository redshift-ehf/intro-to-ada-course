with Ada.Calendar;           use Ada.Calendar;
with Ada.Containers.Ordered_Maps;

--  The list itself: a date, and everything happening on it.
package List_Of_Events.Lists is

   type Event_List is tagged private;

   --  Adds one event to one date. A date that has none yet gets one.
   procedure Add (Events     : in out Event_List;
                  Event_Time :        Time;
                  Event      :        String);

   --  Prints every date in order, with its events under it.
   procedure Display (Events : Event_List);

private

   --  Ordered, so Display gets the dates in order without sorting anything. Time is private and
   --  its "<" lives in Ada.Calendar, so the instantiation has to be handed both operators.
   package Event_Time_Maps is new Ada.Containers.Ordered_Maps
     (Key_Type     => Time,
      Element_Type => Event_Items,
      "<"          => Ada.Calendar."<",
      "="          => Event_Item_Vectors."=");

   --  Extending the map rather than wrapping it: Add and Display then have the map's operations
   --  directly, and a client has none of them, because the derivation is in here.
   type Event_List is new Event_Time_Maps.Map with null record;

end List_Of_Events.Lists;
