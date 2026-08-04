with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Private_Types is

   package Counters is

      --  A private type. Outside this package the name exists and the structure does not: you
      --  may declare one, assign it, and compare it for equality, and nothing else.
      type Counter is private;

      function Start return Counter;
      procedure Bump (C : in out Counter);
      function Value (C : Counter) return Natural;

   private

      --  Only here does Counter become a record. Change this to a plain Natural tomorrow and no
      --  code outside needs touching -- which is the whole return on hiding it.
      type Counter is record
         Count : Natural := 0;
      end record;

   end Counters;

   package body Counters is

      function Start return Counter is
      begin
         return (Count => 0);
      end Start;

      procedure Bump (C : in out Counter) is
      begin
         C.Count := C.Count + 1;
      end Bump;

      function Value (C : Counter) return Natural is
      begin
         return C.Count;
      end Value;

   end Counters;

   use Counters;

   A : Counter := Start;
   B : Counter;
begin
   Bump (A);
   Bump (A);
   Put_Line ("A has been bumped" & Natural'Image (Value (A)) & " times");

   --  Assignment and equality survive privacy. They are the two operations every non-limited
   --  private type keeps.
   B := A;
   Put_Line ("B copied from A: " & Boolean'Image (A = B));

   Bump (B);
   Put_Line ("after bumping B, still equal: " & Boolean'Image (A = B));

   --  Put_Line (Natural'Image (A.Count));
   --  ^ does not compile: Counter has no visible components out here.
end Show_Private_Types;
