with Ada.Strings;
with Ada.Strings.Fixed;

package body Versioning is

   --  Given: a Natural with no leading space, since 'Image supplies one and "1. 3. 23" is not
   --  what anybody means by a version number.
   function Image (N : Natural) return String is
     (Ada.Strings.Fixed.Trim (Natural'Image (N), Ada.Strings.Both));

   function Convert (V : Version) return String is
     (Image (V.Major) & "." & Image (V.Minor) & "." & Image (V.Maintenance));

   function Convert (V : Version) return Float is
     (Float (V.Major) + Float (V.Minor) / 10.0);

end Versioning;
