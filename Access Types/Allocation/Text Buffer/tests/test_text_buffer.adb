with Ada.Command_Line;
with Ada_Check;
with Text_Buffer;

procedure Test_Text_Buffer is
   use Text_Buffer;

   Blank   : constant Text := Make (5);
   Greeted : constant Text := Make ("Hello");
   Nothing : constant Text := null;
begin
   Ada_Check.Suite ("Text Buffer");

   Ada_Check.Equal ("a sized buffer is that long",   Length (Blank),   5);
   Ada_Check.Equal ("a sized buffer starts blank",   Value (Blank),    "     ");
   Ada_Check.Equal ("a content buffer keeps it",     Value (Greeted),  "Hello");
   Ada_Check.Equal ("and is as long as its content", Length (Greeted), 5);

   --  Fill takes its buffer as an `in` parameter and still changes what it designates.
   Fill (Blank, '-');
   Ada_Check.Equal ("Fill overwrites everything", Value (Blank), "-----");

   Fill (Greeted, 'x');
   Ada_Check.Equal ("including a buffer made from content", Value (Greeted), "xxxxx");

   --  Null is a value of the type, not an error, and every operation has an answer for it.
   Ada_Check.Equal ("a null buffer has no length", Length (Nothing), 0);
   Ada_Check.Equal ("and no content",              Value (Nothing),  "");
   Fill (Nothing, '!');
   Ada_Check.Equal ("and filling it does nothing", Value (Nothing),  "");

   --  Two buffers made the same way are two separate objects.
   declare
      One : constant Text := Make ("same");
      Two : constant Text := Make ("same");
   begin
      Ada_Check.Equal ("they start equal", Value (One), Value (Two));
      Fill (One, 'z');
      Ada_Check.Equal ("changing one leaves the other", Value (Two), "same");
      Ada_Check.Equal ("and changes the one",           Value (One), "zzzz");
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Text_Buffer;
