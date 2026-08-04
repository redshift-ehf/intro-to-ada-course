with Ada.Text_IO;

package body Limited_Strings is

   function Init (S : String) return Lim_String is
   begin
      return new String'(S);
   end Init;

   function Init (Max : Positive) return Lim_String is
   begin
      return new String'(1 .. Max => '_');
   end Init;

   procedure Put_Line (LS : Lim_String) is
   begin
      --  Qualified, because this package declares a Put_Line of its own and an unqualified
      --  call here would be this one calling itself.
      Ada.Text_IO.Put_Line (LS.all);
   end Put_Line;

   procedure Copy (From : Lim_String; To : in out Lim_String) is
      Count : constant Natural := Natural'Min (From.all'Length, To.all'Length);
   begin
      To.all (To.all'First .. To.all'First + Count - 1) :=
        From.all (From.all'First .. From.all'First + Count - 1);

      for I in To.all'First + Count .. To.all'Last loop
         To.all (I) := '_';
      end loop;
   end Copy;

   function "=" (Ref, Dut : Lim_String) return Boolean is
      Count : constant Natural := Natural'Min (Ref.all'Length, Dut.all'Length);
   begin
      return Ref.all (Ref.all'First .. Ref.all'First + Count - 1) =
             Dut.all (Dut.all'First .. Dut.all'First + Count - 1);
   end "=";

end Limited_Strings;
