with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;

--  Ada.Strings.Unbounded is not withed here. The parent spec withs and uses it, and a child
--  inherits both -- so To_Unbounded_String and To_String below are already visible.

package body Strings_List_Of_Events.Lists is

   procedure Add (Events     : in out Event_List;
                  Event_Time :        Time;
                  Event      :        String)
   is
      Items : Event_Items;
   begin
      if Events.Contains (Event_Time) then
         Items := Events.Element (Event_Time);
      end if;

      --  To_Unbounded_String where the last version had `new String'(Event)`.
      Items.Append (To_Unbounded_String (Event));

      Events.Include (Event_Time, Items);
   end Add;

   function Date_Image (T : Time) return String is
      Date_Img : constant String := Image (T);
   begin
      return Date_Img (1 .. 10);
   end Date_Image;

   procedure Display (Events : Event_List) is
      use Event_Time_Maps;
   begin
      Put_Line ("EVENTS LIST");
      for C in Events.Iterate loop
         Put_Line ("- " & Date_Image (Key (C)));
         for I of Element (C) loop
            --  To_String where the last version had I.all.
            Put_Line ("    - " & To_String (I));
         end loop;
      end loop;
   end Display;

end Strings_List_Of_Events.Lists;
