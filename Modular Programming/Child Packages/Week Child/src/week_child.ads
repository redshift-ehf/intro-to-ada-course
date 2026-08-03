--  A child package extends its parent. `Week_Child.First` below can see everything in Week
--  without withing it -- a child is inside its parent's declarative region.
--
--  The original chapter calls this Week.Child. Here the parent lives in another task, and a child
--  must sit beside its parent in one compilation closure, so this is a standalone package that
--  withs Week instead. The mechanism it demonstrates is the same.
with Week;

package Week_Child is

   function First return String;

   function Last return String;

end Week_Child;
