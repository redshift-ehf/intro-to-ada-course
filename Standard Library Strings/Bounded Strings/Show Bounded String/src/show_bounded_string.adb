with Ada.Strings;         use Ada.Strings;
with Ada.Strings.Bounded;
with Ada.Text_IO;         use Ada.Text_IO;

--  A bounded string has a maximum length, like a String -- and is not an array, unlike a String.
--  That second half is what makes it assignable at run time.
procedure Show_Bounded_String is
   --  Generic, so the maximum is fixed at instantiation rather than per object.
   package B_Str is new
     Ada.Strings.Bounded.Generic_Bounded_Length (Max => 15);
   use B_Str;

   S1, S2 : Bounded_String;

   procedure Display_String_Info (S : Bounded_String) is
   begin
      Put_Line ("String: '" & To_String (S) & "'");

      --  Length (S), not S'Length. A Bounded_String is not an array, so it has no 'Length --
      --  writing one is a compile error, not a subtlety.
      Put_Line ("String Length: " & Integer'Image (Length (S)));
      Put_Line ("Max.   Length: " & Integer'Image (Max_Length));
   end Display_String_Info;
begin
   S1 := To_Bounded_String ("Hello");
   Display_String_Info (S1);

   --  A different length, into the same variable, with no padding anywhere.
   S2 := To_Bounded_String ("Hello World");
   Display_String_Info (S2);

   --  Too long raises Ada.Strings.Length_Error unless told what to drop. Right drops the tail.
   S1 := To_Bounded_String ("Something longer to say here...", Right);
   Display_String_Info (S1);

   --  Without the truncation argument:
   begin
      S1 := To_Bounded_String ("Something longer to say here...");
      Put_Line ("not reached");
   exception
      when Ada.Strings.Length_Error =>
         Put_Line ("Length_Error, as it must be -- 31 characters will not fit in 15.");
   end;
end Show_Bounded_String;
