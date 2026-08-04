with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;

package body List_Of_Events.Lists is

   procedure Add (Events     : in out Event_List;
                  Event_Time :        Time;
                  Event      :        String)
   is
      Items : Event_Items;
   begin
      --  Whatever is already recorded for that date, or nothing if it is a new one.
      if Events.Contains (Event_Time) then
         Items := Events.Element (Event_Time);
      end if;

      Items.Append (new String'(Event));

      --  Include, not Insert: the date may or may not be there and neither is an error.
      Events.Include (Event_Time, Items);
   end Add;

   --  Image gives "YYYY-MM-DD HH:MM:SS". The first ten characters are the date.
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
            Put_Line ("    - " & I.all);
         end loop;
      end loop;
   end Display;

end List_Of_Events.Lists;
