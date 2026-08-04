with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Assertions; use Ada.Assertions;

procedure Show_Predicates is

   type Week is (Mon, Tue, Wed, Thu, Fri, Sat, Sun);

   --  A range constraint can say Mon .. Fri. It cannot say Mon, Wed and Fri -- those are not
   --  contiguous, and this is what a static predicate is for.
   subtype Work_Week is Week range Mon .. Fri;

   subtype Test_Days is Work_Week
     with Static_Predicate => Test_Days in Mon | Wed | Fri;

   --  A dynamic predicate is checked while the program runs, and may say anything.
   type Tests_Week is array (Week) of Natural
     with Dynamic_Predicate =>
       (for all I in Tests_Week'Range =>
          (case I is
              when Test_Days => Tests_Week (I) > 0,
              when others    => Tests_Week (I) = 0));

   Num_Tests : Tests_Week := (Mon => 3, Tue => 0, Wed => 4, Thu => 0,
                              Fri => 2, Sat => 0, Sun => 0);

   procedure Display_Tests (N : Tests_Week) is
   begin
      for I in Test_Days loop
         Put_Line ("# tests on " & Test_Days'Image (I) & " =>" & Integer'Image (N (I)));
      end loop;
   end Display_Tests;

begin
   Display_Tests (Num_Tests);

   --  Assigning one element does *not* check the predicate. That is deliberate: it lets an
   --  object be built up a piece at a time without every intermediate state having to be valid.
   Num_Tests (Tue) := 2;
   Put_Line ("set Tuesday to 2 -- no check happened");

   --  Passing the whole object to a subprogram does check it. So does assigning the whole
   --  object. This is where the invalid state is caught.
   begin
      Display_Tests (Num_Tests);
      Put_Line ("the predicate did not fire -- was -gnata forgotten?");
   exception
      when Assertion_Error =>
         Put_Line ("caught on the way into Display_Tests, as it should be");
   end;
end Show_Predicates;
