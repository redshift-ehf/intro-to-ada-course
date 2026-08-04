--  A tagged type and an extension of it, each with its own constructors and its own Image.
package Type_Extension is

   type T_Float is tagged record
      F : Float;
   end record;

   function Init (Value : Float) return T_Float;

   function Init (Value : Integer) return T_Float;

   function Image (Obj : T_Float) return String;

   --  `with record` adds components. A plain derived type could not.
   type T_Mixed is new T_Float with record
      I : Integer;
   end record;

   --  A function returning the tagged type is a primitive, so an extension must override every
   --  one of them -- there is no sensible way to inherit something that builds a T_Float when a
   --  T_Mixed is wanted.
   overriding function Init (Value : Float) return T_Mixed;

   overriding function Init (Value : Integer) return T_Mixed;

   overriding function Image (Obj : T_Mixed) return String;

end Type_Extension;
