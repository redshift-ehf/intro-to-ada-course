--  One type, three shapes, and different components for each.
--
--  An original exercise; AdaCore's Laboratories has no More About Records chapter.
package Shapes is

   type Shape_Kind is (Circle, Rectangle, Triangle);

   --  Component names must be distinct across the whole record, even between variants that can
   --  never coexist -- which is why the triangle's height is called Vertical.
   type Shape (Kind : Shape_Kind) is record
      case Kind is
         when Circle =>
            Radius : Float;
         when Rectangle =>
            Width, Height : Float;
         when Triangle =>
            Base, Vertical : Float;
      end case;
   end record;

   function Area (S : Shape) return Float;

   function Name (S : Shape) return String;

   function Is_Round (S : Shape) return Boolean;

end Shapes;
