with Ada.Strings;       use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO;       use Ada.Text_IO;

--  Insert, Overwrite, Delete and Trim each come twice: as a function returning a new string, and
--  as a procedure modifying one in place. The pair is not a convenience -- they behave
--  differently, because a String cannot change length.
procedure Show_Adapted_Strings is

   S : constant String := "Hello World";
   P : constant String := "World";
   N : constant String := "Beautiful";

   procedure Display_Adapted_String
     (Source   : String;
      Before   : Positive;
      New_Item : String;
      Pattern  : String)
   is
      --  In-place copies, all exactly Source'Length characters, now and forever.
      S_Ins_In : String := Source;
      S_Ovr_In : String := Source;
      S_Del_In : String := Source;

      --  The function versions. Each is as long as its answer needs to be.
      S_Ins : constant String := Insert (Source, Before, New_Item & " ");
      S_Ovr : constant String := Overwrite (Source, Before, New_Item);
      S_Del : constant String :=
        Trim (Delete (Source, Before, Before + Pattern'Length - 1), Ada.Strings.Right);
   begin
      --  The procedure versions cannot grow their argument, so they need to be told what to do
      --  with what does not fit. Right means "drop it off the right-hand end".
      Insert (S_Ins_In, Before, New_Item, Right);
      Overwrite (S_Ovr_In, Before, New_Item, Right);

      --  Delete does not shrink the string either -- it blanks the range instead.
      Delete (S_Del_In, Before, Before + Pattern'Length - 1);

      Put_Line ("Original:  '" & Source & "'");
      New_Line;
      Put_Line ("Insert:    '" & S_Ins & "'");
      Put_Line ("Overwrite: '" & S_Ovr & "'");
      Put_Line ("Delete:    '" & S_Del & "'");
      New_Line;
      Put_Line ("Insert    (in-place): '" & S_Ins_In & "'");
      Put_Line ("Overwrite (in-place): '" & S_Ovr_In & "'");
      Put_Line ("Delete    (in-place): '" & S_Del_In & "'");
      New_Line;
      Put_Line ("Function version is" & Integer'Image (S_Ins'Length) & " characters,");
      Put_Line ("in-place version is" & Integer'Image (S_Ins_In'Length) & " -- the same as the");
      Put_Line ("original, which is the whole difference.");
   end Display_Adapted_String;

   Idx : Natural;
begin
   Idx := Index (Source => S, Pattern => P);

   if Idx > 0 then
      Display_Adapted_String (S, Idx, N, P);
   end if;
end Show_Adapted_Strings;
