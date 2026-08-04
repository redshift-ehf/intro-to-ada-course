--  Two tests that go wrong in two different ways, and something that copes with both.
package Numerical_Exception is

   subtype Test_ID is Positive range 1 .. 2;

   Custom_Exception : exception;

   --  Test 1 walks off the end of an array, so Constraint_Error. Test 2 raises
   --  Custom_Exception with a message. Given.
   procedure Num_Exception_Test (ID : Test_ID);

   --  Runs the test and reports what went wrong, without letting it escape.
   procedure Check_Exception (ID : Test_ID);

end Numerical_Exception;
