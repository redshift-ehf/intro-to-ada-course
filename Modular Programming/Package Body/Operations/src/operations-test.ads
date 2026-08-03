--  A child package. Its name is Operations.Test, and GNAT expects that in `operations-test.ads`.
--  A child sees its parent's declarations without withing it.
package Operations.Test is

   procedure Display (A, B : Integer);

end Operations.Test;
