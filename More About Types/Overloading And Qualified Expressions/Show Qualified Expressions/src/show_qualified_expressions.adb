with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Qualified_Expressions is
   type SSID is new Integer;

   --  Three Converts. Two take an SSID and differ only in what they return; the third takes an
   --  Integer. Ada is happy with all of this -- overloading covers the return type too.
   function Convert (Self : SSID) return Integer is (Integer (Self));
   function Convert (Self : SSID) return String is ("SSID" & SSID'Image (Self));
   function Convert (Self : Integer) return String is ("Integer" & Integer'Image (Self));

   --  Convert (123_145_299) on its own is ambiguous here: SSID is derived from Integer, so the
   --  literal could be either, and both readings have a Convert returning String. A qualified
   --  expression says which type the value is, and the ambiguity goes away.
   As_SSID    : constant String := Convert (SSID'(123_145_299));
   As_Integer : constant String := Convert (Integer'(123_145_299));

   --  The same notation qualifies an aggregate, which is where it is needed most often.
   type Point is record
      A, B : Integer;
   end record;

   P : constant Point   := Point'(12, 15);
   N : constant Integer := Integer'(12);

   --  And the other Convert is still reachable: what is wanted here is an Integer.
   Number : constant Integer := Convert (SSID'(7));
begin
   Put_Line ("read as an SSID:    " & As_SSID);
   Put_Line ("read as an Integer: " & As_Integer);
   Put_Line ("Point'(12, 15) is" & Integer'Image (P.A) & Integer'Image (P.B));
   Put_Line ("Integer'(12) is" & Integer'Image (N));
   Put_Line ("and the Integer Convert gives" & Integer'Image (Number));
end Show_Qualified_Expressions;
