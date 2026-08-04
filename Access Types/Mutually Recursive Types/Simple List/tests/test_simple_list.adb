with Ada.Command_Line;
with Ada_Check;
with Simple_List;

procedure Test_Simple_List is
   use Simple_List;

   L     : List;
   Empty : List;
begin
   Ada_Check.Suite ("Simple List");

   --  Everything must have an answer for the empty list, and none of it may follow a null.
   Ada_Check.Equal ("an empty list is nothing long", Length (Empty), 0);
   Ada_Check.Equal ("and sums to nothing",           Sum (Empty),    0);
   Ada_Check.Check ("and contains nothing",          not Contains (Empty, 0));

   Push (L, 1);
   Push (L, 2);
   Push (L, 3);

   Ada_Check.Equal ("three pushes, three nodes", Length (L), 3);
   Ada_Check.Equal ("1 + 2 + 3",                 Sum (L),    6);

   --  Push adds to the front, so the last one in is the head.
   Ada_Check.Equal ("the head is the last pushed", Integer (L.Head.Content), 3);
   Ada_Check.Equal ("then the one before it",      Integer (L.Head.Next.Content), 2);
   Ada_Check.Equal ("then the first",              Integer (L.Head.Next.Next.Content), 1);
   Ada_Check.Check ("and then the end",            L.Head.Next.Next.Next = null);

   Ada_Check.Check ("it contains what went in",   Contains (L, 2));
   Ada_Check.Check ("the head counts too",        Contains (L, 3));
   Ada_Check.Check ("and the tail",               Contains (L, 1));
   Ada_Check.Check ("but not what did not",       not Contains (L, 4));

   --  A value pushed twice is two nodes, because a list is not a set.
   Push (L, 2);
   Ada_Check.Equal ("a repeat is another node", Length (L), 4);
   Ada_Check.Equal ("and counts again in the sum", Sum (L), 8);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Simple_List;
