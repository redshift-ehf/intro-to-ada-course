--  A parent package with a private type. Its child gets in; nobody else does.
package Show_Child_Privacy is

   type Reading is private;

   function Make (Celsius : Integer) return Reading;

private

   --  Visible to this package's body, to its private descendants, and to no one else.
   type Reading is record
      Celsius : Integer := 0;
   end record;

   --  A private operation, for the same audience.
   function Doubled (R : Reading) return Reading;

end Show_Child_Privacy;
