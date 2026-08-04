with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Limited_Types is

   package Handles is

      --  `limited private` takes away the two operations a plain private type keeps: there is
      --  no assignment and no predefined equality. Whatever this type can do, somebody declared.
      type Handle is limited private;

      procedure Open (H : in out Handle; Id : Positive);
      procedure Close (H : in out Handle);
      function Is_Open (H : Handle) return Boolean;
      function Id_Of (H : Handle) return Natural;

   private

      type Handle is limited record
         Id   : Natural := 0;
         Open : Boolean := False;
      end record;

   end Handles;

   package body Handles is

      procedure Open (H : in out Handle; Id : Positive) is
      begin
         H.Id := Id;
         H.Open := True;
      end Open;

      procedure Close (H : in out Handle) is
      begin
         H.Open := False;
      end Close;

      function Is_Open (H : Handle) return Boolean is
      begin
         return H.Open;
      end Is_Open;

      function Id_Of (H : Handle) return Natural is
      begin
         return H.Id;
      end Id_Of;

   end Handles;

   use Handles;

   A : Handle;
   B : Handle;
begin
   Open (A, 7);
   Put_Line ("A is open: " & Boolean'Image (Is_Open (A))
             & ", id" & Natural'Image (Id_Of (A)));
   Put_Line ("B is open: " & Boolean'Image (Is_Open (B)));

   Close (A);
   Put_Line ("after closing, A is open: " & Boolean'Image (Is_Open (A)));

   --  B := A;
   --  ^ does not compile: Handle is limited. Copying a handle would give two names for one
   --    underlying thing, and closing through one would leave the other stale -- which is
   --    exactly the bug `limited` exists to make impossible.

   --  if A = B then ...
   --  ^ nor this: there is no predefined equality either.
end Show_Limited_Types;
