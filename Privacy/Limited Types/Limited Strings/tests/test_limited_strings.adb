with Ada.Command_Line;
with Ada_Check;
with Limited_Strings;

procedure Test_Limited_Strings is
   use Limited_Strings;

   S1 : constant Lim_String := Init ("Hello World");
   S2 : constant Lim_String := Init (26);
   S3 : constant Lim_String := Init ("Hello");
   S4 : Lim_String := Init (30);

   function Shown (LS : Lim_String) return String is
      procedure Call is
      begin
         Put_Line (LS);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Shown;
begin
   Ada_Check.Suite ("Limited Strings");

   Ada_Check.Equal ("built from text", Shown (S1), "Hello World");
   Ada_Check.Equal ("built from a size", Shown (S2), "__________________________");

   --  "=" compares only as far as the shorter one, so a prefix counts as equal.
   Ada_Check.Check ("different lengths and contents differ", not (S1 = S2));
   Ada_Check.Check ("a prefix compares equal",               S1 = S3);
   Ada_Check.Check ("and the other way round",               S3 = S1);
   Ada_Check.Check ("something equals itself",               S1 = S1);

   --  Copy fills what it can and underscores the rest, so S4 keeps its own length.
   Copy (From => S1, To => S4);
   Ada_Check.Equal ("copied in, padded out",
                    Shown (S4), "Hello World___________________");
   Ada_Check.Check ("and now compares equal to its source", S1 = S4);

   --  Copying a long one into a short one keeps only what fits.
   declare
      Short : Lim_String := Init (5);
   begin
      Copy (From => S1, To => Short);
      Ada_Check.Equal ("truncated to fit", Shown (Short), "Hello");
      Ada_Check.Check ("still equal as far as it goes", Short = S1);
   end;

   --  S4 := S1;
   --  ^ would not compile. Lim_String is limited, which is the entire point: an assignment
   --    would copy the access value and leave two names for one String.

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Limited_Strings;
