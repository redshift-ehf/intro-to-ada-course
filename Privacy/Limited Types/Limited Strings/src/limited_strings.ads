--  A string you cannot copy by accident.
package Limited_Strings is

   --  Limited private: no assignment, no predefined equality. Both are supplied here instead,
   --  as Copy and as an explicit "=", so that each does the right thing rather than the
   --  obvious wrong one.
   type Lim_String is limited private;

   function Init (S : String) return Lim_String;

   function Init (Max : Positive) return Lim_String;

   procedure Put_Line (LS : Lim_String);

   --  Copies as much as fits, then pads the rest of To with underscores.
   procedure Copy (From : Lim_String; To : in out Lim_String);

   --  Compares only as far as the shorter of the two.
   function "=" (Ref, Dut : Lim_String) return Boolean;

private

   type Lim_String is access String;

end Limited_Strings;
