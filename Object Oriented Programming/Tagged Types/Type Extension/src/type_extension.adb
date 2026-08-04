package body Type_Extension is

   function Init (Value : Float) return T_Float is
   begin
      return (F => Value);
   end Init;

   function Init (Value : Integer) return T_Float is
   begin
      return (F => Float (Value));
   end Init;

   function Image (Obj : T_Float) return String is
   begin
      return "{ F => " & Float'Image (Obj.F) & " }";
   end Image;

   function Init (Value : Float) return T_Mixed is
   begin
      return (F => Value, I => Integer (Value));
   end Init;

   function Init (Value : Integer) return T_Mixed is
   begin
      return (F => Float (Value), I => Value);
   end Init;

   function Image (Obj : T_Mixed) return String is
   begin
      --  Not a call to the parent's Image and then some. It could be -- T_Float (Obj) is a view
      --  conversion and Image of that would give the first half -- but writing it out keeps the
      --  format in one place per type.
      return "{ F => " & Float'Image (Obj.F)
             & ", I => " & Integer'Image (Obj.I) & " }";
   end Image;

end Type_Extension;
