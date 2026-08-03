with Ada.Command_Line;
with Ada_Check;
with Months;

procedure Test_Months is
begin
   Ada_Check.Suite ("Months");

   Ada_Check.Equal ("January is named",   Months.Jan, "January");
   Ada_Check.Equal ("September is named", Months.Sep, "September");
   Ada_Check.Equal ("December is named",  Months.Dec, "December");

   declare
      Printed : constant String :=
        Ada_Check.Output_Of (Months.Display_Months'Access);
   begin
      Ada_Check.Equal
        (Name     => "the whole list, in order",
         Actual   => Printed,
         Expected =>
           "Months:" & ASCII.LF
           & "- January" & ASCII.LF & "- February" & ASCII.LF & "- March" & ASCII.LF
           & "- April" & ASCII.LF & "- May" & ASCII.LF & "- June" & ASCII.LF
           & "- July" & ASCII.LF & "- August" & ASCII.LF & "- September" & ASCII.LF
           & "- October" & ASCII.LF & "- November" & ASCII.LF & "- December");
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Months;
