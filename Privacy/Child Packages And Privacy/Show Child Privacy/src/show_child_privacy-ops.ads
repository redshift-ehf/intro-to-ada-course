--  A child package. Its *body* can see the parent's private part; this spec, being public,
--  cannot -- so Reading stays opaque here, exactly as it is to any other package.
package Show_Child_Privacy.Ops is

   function Image (R : Reading) return String;

   function Warmer (R : Reading) return Reading;

end Show_Child_Privacy.Ops;
