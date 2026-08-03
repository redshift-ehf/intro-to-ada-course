with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Days is
   --  An enumeration is a type whose values are named, and that is all it is. These are not
   --  integers with nicer spellings: Monday is a value of Day and of nothing else.
   type Day is (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);

   procedure Report (D : Day) is
   begin
      --  The compiler knows every value of Day, so it knows whether a case statement covers them
      --  all. Delete one of these alternatives and it will say so.
      case D is
         when Saturday | Sunday => Put_Line (Day'Image (D) & " is the weekend");
         when Monday .. Friday  => Put_Line (Day'Image (D) & " is a working day");
      end case;
   end Report;
begin
   for D in Day loop
      Report (D);
   end loop;

   --  'Pos gives the position number, counting from zero, and 'Succ the next value along.
   Put_Line ("There are" & Integer'Image (Day'Pos (Day'Last) + 1) & " of them");
   Put_Line ("The day after Monday is " & Day'Image (Day'Succ (Monday)));
end Show_Days;
