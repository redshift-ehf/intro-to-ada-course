with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Protected_Objects is

   --  A protected object reads like a small package: operations in front, data behind
   --  `private`. What it adds is that only one task is inside it at a time.
   protected Obj is
      procedure Set (V : Integer);
      procedure Bump;
      function Get return Integer;
   private
      Local : Integer := 0;
   end Obj;

   protected body Obj is
      --  A procedure may change the data, and gets exclusive access while it runs.
      procedure Set (V : Integer) is
      begin
         Local := V;
      end Set;

      procedure Bump is
      begin
         Local := Local + 1;
      end Bump;

      --  A function may not change it, and in exchange several tasks may read at once.
      function Get return Integer is
      begin
         return Local;
      end Get;
   end Obj;

   task type Bumper;
   task body Bumper is
   begin
      for I in 1 .. 1_000 loop
         Obj.Bump;
      end loop;
   end Bumper;

begin
   Obj.Set (5);
   Put_Line ("Number is: " & Integer'Image (Obj.Get));

   --  Back to nought, so the count below is exactly the increments and nothing else.
   Obj.Set (0);

   --  Four tasks, a thousand increments each. Every one goes through Obj.Bump, which admits one
   --  task at a time -- so the answer is exactly 4000 rather than whatever a race would leave.
   --  `Local := Local + 1` is a read and a write, and unprotected it would lose updates.
   declare
      A, B, C, D : Bumper;
   begin
      null;
   end;

   Put_Line ("after 4000 increments from four tasks:" & Integer'Image (Obj.Get));
end Show_Protected_Objects;
