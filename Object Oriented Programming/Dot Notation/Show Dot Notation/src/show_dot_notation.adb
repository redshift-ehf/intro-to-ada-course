with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Dot_Notation is

   package P is
      type Counter is tagged record
         Value : Integer := 0;
      end record;

      procedure Show (Self : Counter);
      procedure Bump (Self : in out Counter; By : Integer);

      type Loud_Counter is new Counter with null record;

      overriding procedure Show (Self : Loud_Counter);
   end P;

   package body P is
      procedure Show (Self : Counter) is
      begin
         Put_Line ("counter is" & Integer'Image (Self.Value));
      end Show;

      procedure Bump (Self : in out Counter; By : Integer) is
      begin
         Self.Value := Self.Value + By;
      end Bump;

      procedure Show (Self : Loud_Counter) is
      begin
         Put_Line ("COUNTER IS" & Integer'Image (Self.Value) & "!");
      end Show;
   end P;

   use P;

   C : Counter := (Value => 1);
   L : Loud_Counter := (Value => 10);

   Wide : Counter'Class := L;
begin
   --  `C.Show` and `Show (C)` are the same call written two ways. The dot form works whenever
   --  the dispatching parameter comes first, which is why it is worth putting it first.
   C.Show;
   Show (C);

   --  Further parameters follow in the brackets as usual.
   C.Bump (5);
   C.Show;

   --  Dot notation dispatches exactly as the bracket form does -- it is notation, not a
   --  different mechanism.
   L.Show;
   Wide.Show;

   --  Bump was never overridden, so Loud_Counter inherits it and this reaches Counter's body.
   Wide.Bump (100);
   Wide.Show;
end Show_Dot_Notation;
