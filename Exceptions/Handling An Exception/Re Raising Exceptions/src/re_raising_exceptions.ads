--  The same two tests, but the handler reports and then passes the problem on.
package Re_Raising_Exceptions is

   subtype Test_ID is Positive range 1 .. 2;

   Custom_Exception  : exception;
   Another_Exception : exception;

   --  Given, and the same as in the last exercise.
   procedure Num_Exception_Test (ID : Test_ID);

   --  Reports, then re-raises Constraint_Error unchanged, or raises Another_Exception in place
   --  of anything else.
   procedure Check_Exception (ID : Test_ID);

end Re_Raising_Exceptions;
