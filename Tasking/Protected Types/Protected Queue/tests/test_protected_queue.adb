with Ada.Command_Line;
with Ada_Check;
with Protected_Queue;

procedure Test_Protected_Queue is

   type Small_Index is mod 5;
   package Float_Queue is new Protected_Queue (Queue_Index => Small_Index, Item => Float);

   package Int_Queue is new Protected_Queue (Queue_Index => Small_Index, Item => Integer);

   Q : Float_Queue.Queue;
   Value : Float;
begin
   Ada_Check.Suite ("Protected Queue");

   Ada_Check.Check ("a new queue is empty",  Q.Empty);
   Ada_Check.Check ("and is not full",       not Q.Full);

   Q.Push (10.0);
   Q.Push (11.5);
   Q.Push (13.0);
   Ada_Check.Check ("after three pushes it is not empty", not Q.Empty);
   Ada_Check.Check ("and still not full",                 not Q.Full);

   Q.Pop (Value);
   Ada_Check.Equal ("first in, first out", Value, 10.0);
   Q.Pop (Value);
   Ada_Check.Equal ("then the second",     Value, 11.5);
   Q.Pop (Value);
   Ada_Check.Equal ("then the third",      Value, 13.0);
   Ada_Check.Check ("and it is empty again", Q.Empty);

   --  Five is the modulus, so five is the capacity.
   for I in 1 .. 5 loop
      Q.Push (Float (I));
   end loop;
   Ada_Check.Check ("five pushes fill it", Q.Full);

   --  Emptying and refilling crosses the wrap-around point, which is where an index that did
   --  not wrap would start returning the wrong element.
   for I in 1 .. 5 loop
      Q.Pop (Value);
      Ada_Check.Equal ("drained in order," & Integer'Image (I), Value, Float (I));
   end loop;

   for I in 6 .. 10 loop
      Q.Push (Float (I));
   end loop;
   for I in 6 .. 10 loop
      Q.Pop (Value);
      Ada_Check.Equal ("and again past the wrap," & Integer'Image (I), Value, Float (I));
   end loop;

   --  Two tasks and a queue that holds five, moving twenty values. The producer blocks when it
   --  is full and the consumer blocks when it is empty -- so this needs no delays anywhere and
   --  comes out in order every time.
   declare
      Shared : Int_Queue.Queue;
      Wrong  : Natural := 0;

      task Producer;
      task body Producer is
      begin
         for I in 100 .. 119 loop
            Shared.Push (I);
         end loop;
      end Producer;

      Got : Integer;
   begin
      for I in 100 .. 119 loop
         Shared.Pop (Got);
         if Got /= I then
            Wrong := Wrong + 1;
         end if;
      end loop;

      Ada_Check.Equal ("twenty values through a queue of five, none out of order", Wrong, 0);
      Ada_Check.Check ("and the queue is empty afterwards", Shared.Empty);
   end;

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Protected_Queue;
