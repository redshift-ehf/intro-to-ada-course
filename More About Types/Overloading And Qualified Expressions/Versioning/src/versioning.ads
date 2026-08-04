--  A version number, and two ways of reading it back.
package Versioning is

   type Version is record
      Major       : Natural;
      Minor       : Natural;
      Maintenance : Natural;
   end record;

   --  Two functions of the same name over the same argument, differing only in return type.
   --  The caller's context picks between them.
   function Convert (V : Version) return String;

   function Convert (V : Version) return Float;

end Versioning;
