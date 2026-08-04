with Ada.Command_Line;
with Ada_Check;
with Display_Service;

procedure Test_Display_Service is
   use Display_Service;

   function Shown return String is
      procedure Call is
         --  Declared inside, so the task is created and finished within the capture.
         D : Display_Task;
      begin
         D.Display ("Hello");
         D.Display ("Hello again");
         D.Display (55);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Shown;

   function Two_Services return String is
      procedure Call is
         A : Display_Task;
         B : Display_Task;
      begin
         --  Two independent services, interleaved by the caller. Each call blocks until its
         --  own line is printed, so the order is the caller's and not the scheduler's.
         A.Display ("from A");
         B.Display ("from B");
         A.Display (1);
         B.Display (2);
      end Call;
   begin
      return Ada_Check.Output_Of (Call'Access);
   end Two_Services;
begin
   Ada_Check.Suite ("Display Service");

   Ada_Check.Equal
     (Name     => "strings and an integer, in the order they were sent",
      Actual   => Shown,
      Expected => "Hello" & ASCII.LF & "Hello again" & ASCII.LF & " 55");

   Ada_Check.Equal
     (Name     => "two services keep the caller's order",
      Actual   => Two_Services,
      Expected => "from A" & ASCII.LF & "from B" & ASCII.LF & " 1" & ASCII.LF & " 2");

   --  Run it again: a rendezvous is not a race, so this is the same every time.
   Ada_Check.Equal ("and again, identically", Shown,
                    "Hello" & ASCII.LF & "Hello again" & ASCII.LF & " 55");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Display_Service;
