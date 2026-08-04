with Ada.Real_Time;

--  An event that announces itself at a time somebody else chooses.
package Event_Manager is

   task type Manager is
      --  Told which event it is...
      entry Start (ID : Natural);
      --  ...and when to announce it.
      entry Event (At_Time : Ada.Real_Time.Time);
   end Manager;

end Event_Manager;
