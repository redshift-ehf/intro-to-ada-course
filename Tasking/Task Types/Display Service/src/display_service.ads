--  A task that displays whatever it is handed, one caller at a time.
package Display_Service is

   task type Display_Task is
      --  Two entries of the same name, telling apart by parameter type -- entries overload
      --  exactly as subprograms do.
      entry Display (Text : String);
      entry Display (Value : Integer);
   end Display_Task;

end Display_Service;
