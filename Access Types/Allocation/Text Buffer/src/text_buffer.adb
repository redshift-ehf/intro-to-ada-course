package body Text_Buffer is

   function Make (Size : Positive) return Text is
   begin
      --  A qualified aggregate: the bounds come from the aggregate's own indices.
      return new String'(1 .. Size => ' ');
   end Make;

   function Make (Content : String) return Text is
   begin
      return new String'(Content);
   end Make;

   function Length (T : Text) return Natural is
   begin
      if T = null then
         return 0;
      end if;
      return T.all'Length;
   end Length;

   procedure Fill (T : Text; C : Character) is
   begin
      --  T is an `in` parameter and this still works: the access value is not being changed,
      --  only the String it designates.
      if T /= null then
         T.all := (others => C);
      end if;
   end Fill;

   function Value (T : Text) return String is
   begin
      if T = null then
         return "";
      end if;
      return T.all;
   end Value;

end Text_Buffer;
