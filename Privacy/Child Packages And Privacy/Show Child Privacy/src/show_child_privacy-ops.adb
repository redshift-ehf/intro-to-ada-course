package body Show_Child_Privacy.Ops is

   function Image (R : Reading) return String is
   begin
      --  R.Celsius is reachable here. This is a child's body, and a child's body sees its
      --  parent's private part -- which is how you add operations to a private type without
      --  either reopening the parent or giving the component away to everyone.
      return Integer'Image (R.Celsius) & " C";
   end Image;

   function Warmer (R : Reading) return Reading is
   begin
      --  And the parent's private subprograms are reachable too, unqualified.
      return Doubled (R);
   end Warmer;

end Show_Child_Privacy.Ops;
