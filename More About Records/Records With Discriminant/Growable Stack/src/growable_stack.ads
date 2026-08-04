--  A stack whose capacity is chosen per object, by a discriminant.
--
--  An original exercise; AdaCore's Laboratories has no More About Records chapter.
package Growable_Stack is

   type Items_Array is array (Positive range <>) of Integer;

   type Stack (Max_Len : Positive) is record
      Items : Items_Array (1 .. Max_Len);
      Len   : Natural := 0;
   end record;

   function Capacity (S : Stack) return Natural;

   function Is_Empty (S : Stack) return Boolean;

   function Is_Full (S : Stack) return Boolean;

   --  Does nothing to a full stack, rather than raising.
   procedure Push (S : in out Stack; Value : Integer);

   --  Gives back 0 from an empty stack, and leaves it empty.
   procedure Pop (S : in out Stack; Value : out Integer);

   --  The top without removing it, or 0 if there is none.
   function Peek (S : Stack) return Integer;

end Growable_Stack;
