with Ada.Text_IO; use Ada.Text_IO;

package body Display_Service is

   task body Display_Task is
   begin
      loop
         select
            --  Printing *inside* the rendezvous is what makes this deterministic: the caller
            --  is held until the line is out, so calls in order produce lines in order.
            accept Display (Text : String) do
               Put_Line (Text);
            end Display;
         or
            accept Display (Value : Integer) do
               Put_Line (Integer'Image (Value));
            end Display;
         or
            --  Nothing else can call once the master is finished, so the task may end.
            terminate;
         end select;
      end loop;
   end Display_Task;

end Display_Service;
