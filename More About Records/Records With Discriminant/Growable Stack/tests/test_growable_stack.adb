with Ada.Command_Line;
with Ada_Check;
with Growable_Stack;

procedure Test_Growable_Stack is
   use Growable_Stack;

   Small : Stack (3);
   Big   : Stack (10);
   Taken : Integer;
begin
   Ada_Check.Suite ("Growable Stack");

   --  Two objects of one type, different sizes. That is what the discriminant buys.
   Ada_Check.Equal ("a small stack holds three", Capacity (Small), 3);
   Ada_Check.Equal ("a big one holds ten",       Capacity (Big),   10);

   Ada_Check.Check ("a new stack is empty",     Is_Empty (Small));
   Ada_Check.Check ("and is not full",          not Is_Full (Small));
   Ada_Check.Equal ("peeking at nothing is 0",  Peek (Small), 0);

   Push (Small, 10);
   Push (Small, 20);
   Ada_Check.Check ("after two pushes it is not empty", not Is_Empty (Small));
   Ada_Check.Equal ("and the top is the last pushed",   Peek (Small), 20);

   Push (Small, 30);
   Ada_Check.Check ("three pushes fill it", Is_Full (Small));

   --  The fourth push has nowhere to go, and must not overwrite anything.
   Push (Small, 40);
   Ada_Check.Check ("a fourth push leaves it full", Is_Full (Small));
   Ada_Check.Equal ("and does not change the top",  Peek (Small), 30);

   Pop (Small, Taken);
   Ada_Check.Equal ("popping gives the top back", Taken, 30);
   Ada_Check.Equal ("and the next one is exposed", Peek (Small), 20);
   Ada_Check.Check ("and it is no longer full",    not Is_Full (Small));

   Pop (Small, Taken);
   Pop (Small, Taken);
   Ada_Check.Equal ("the last one out is the first one in", Taken, 10);
   Ada_Check.Check ("and now it is empty", Is_Empty (Small));

   --  Popping an empty stack must give an answer rather than reading off the end.
   Pop (Small, Taken);
   Ada_Check.Equal ("popping nothing gives 0", Taken, 0);
   Ada_Check.Check ("and leaves it empty",     Is_Empty (Small));

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Growable_Stack;
