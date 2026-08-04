with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Returning_Arrays is
   type Days is (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);

   --  A function may return an unconstrained array. The caller does not have to say in advance
   --  how long the answer will be, and nothing is allocated on the heap to manage it.
   function Day_Name (Day : Days) return String is
   begin
      return
        (case Day is
         when Monday    => "Monday",
         when Tuesday   => "Tuesday",
         when Wednesday => "Wednesday",
         when Thursday  => "Thursday",
         when Friday    => "Friday",
         when Saturday  => "Saturday",
         when Sunday    => "Sunday");
   end Day_Name;

   type Integer_Array is array (Natural range <>) of Integer;

   --  No bounds written here either: they come from the value.
   Source : constant Integer_Array := (1, 2, 3, 4);

   --  And here they come from another array, so the two cannot drift apart.
   Scaled : Integer_Array (Source'Range);
begin
   Put_Line ("First day is " & Day_Name (Days'First));
   Put_Line ("Last day is " & Day_Name (Days'Last));

   for I in Source'Range loop
      Scaled (I) := Source (I) * 10;
   end loop;

   for I in Scaled'Range loop
      Put (Integer'Image (Scaled (I)));
   end loop;
   New_Line;
end Show_Returning_Arrays;
