with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Generic_Packages is

   --  A generic package. Same `generic` and formals, then `package` instead of a subprogram.
   generic
      type T is private;
   package Element is

      procedure Set (E : T);
      procedure Reset;
      function Get return T;
      function Is_Valid return Boolean;

      Invalid_Element : exception;

   private
      Value : T;
      Valid : Boolean := False;
   end Element;

   package body Element is

      procedure Set (E : T) is
      begin
         Value := E;
         Valid := True;
      end Set;

      procedure Reset is
      begin
         Valid := False;
      end Reset;

      function Get return T is
      begin
         if not Valid then
            raise Invalid_Element;
         end if;
         return Value;
      end Get;

      function Is_Valid return Boolean is (Valid);

   end Element;

   --  One generic, two instances, two separate stores.
   package I is new Element (T => Integer);
   package S is new Element (T => Character);

   procedure Report is
   begin
      Put_Line ("integer set: " & Boolean'Image (I.Is_Valid)
                & ", character set: " & Boolean'Image (S.Is_Valid));
   end Report;
begin
   Report;

   I.Set (5);
   Report;
   Put_Line ("the integer is now" & Integer'Image (I.Get));

   S.Set ('a');
   Put_Line ("and the character is " & S.Get);

   I.Reset;
   Report;

   --  Note that everything a generic package declares is instantiated with it -- the private
   --  Value and Valid included, so I and S have a store each rather than sharing one.
end Show_Generic_Packages;
