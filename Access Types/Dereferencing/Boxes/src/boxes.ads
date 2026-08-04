--  An Integer on the heap, and the difference between changing a pointer and changing what it
--  points at.
--
--  An original exercise; AdaCore's Laboratories has no Access Types chapter.
package Boxes is

   type Int_Box is access Integer;

   function Make (Value : Integer) return Int_Box;

   function Get (B : Int_Box) return Integer;

   --  Note the mode. B is `in`, and Set still changes the Integer: what may not change is the
   --  access value itself.
   procedure Set (B : Int_Box; Value : Integer);

   function Is_Empty (B : Int_Box) return Boolean;

   --  Exchanges the two Integers, leaving both boxes where they are.
   procedure Swap (A, B : Int_Box);

end Boxes;
