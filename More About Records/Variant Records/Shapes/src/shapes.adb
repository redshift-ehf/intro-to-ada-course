with Ada.Numerics;

package body Shapes is

   function Area (S : Shape) return Float is
   begin
      --  Each branch touches only components that exist in it. Reaching for S.Radius under
      --  `when Rectangle` would not compile, which is the whole safety of a variant record.
      case S.Kind is
         when Circle =>
            return Ada.Numerics.Pi * S.Radius * S.Radius;
         when Rectangle =>
            return S.Width * S.Height;
         when Triangle =>
            return 0.5 * S.Base * S.Vertical;
      end case;
   end Area;

   function Name (S : Shape) return String is
   begin
      case S.Kind is
         when Circle    => return "Circle";
         when Rectangle => return "Rectangle";
         when Triangle  => return "Triangle";
      end case;
   end Name;

   function Is_Round (S : Shape) return Boolean is
   begin
      return S.Kind = Circle;
   end Is_Round;

end Shapes;
