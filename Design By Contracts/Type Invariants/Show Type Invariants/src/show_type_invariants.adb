with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Assertions; use Ada.Assertions;

procedure Show_Type_Invariants is

   package Accounts is

      --  A type invariant goes on a *private* type. That is the whole point: because callers
      --  cannot reach inside, every way of making or changing one goes through this package,
      --  and so every one of them can be checked.
      type Account is private
        with Type_Invariant => Check (Account);

      function Open (Balance : Integer) return Account;
      function Withdraw (A : Account; Amount : Integer) return Account;
      function Balance_Of (A : Account) return Integer;
      function Check (A : Account) return Boolean;

   private

      type Account is record
         Balance : Integer := 0;
      end record;

      --  Never overdrawn.
      function Check (A : Account) return Boolean is (A.Balance >= 0);

   end Accounts;

   package body Accounts is

      function Open (Balance : Integer) return Account is
      begin
         return (Balance => Balance);
      end Open;

      function Withdraw (A : Account; Amount : Integer) return Account is
      begin
         return (Balance => A.Balance - Amount);
      end Withdraw;

      function Balance_Of (A : Account) return Integer is
      begin
         return A.Balance;
      end Balance_Of;

   end Accounts;

   use Accounts;

   A : Account := Open (100);
begin
   Put_Line ("opened with" & Integer'Image (Balance_Of (A)));

   A := Withdraw (A, 30);
   Put_Line ("after withdrawing 30:" & Integer'Image (Balance_Of (A)));

   begin
      --  Checked as the function returns, so the bad Account never reaches A.
      A := Withdraw (A, 1_000);
      Put_Line ("the invariant did not fire -- was -gnata forgotten?");
   exception
      when Assertion_Error =>
         Put_Line ("overdraft refused by the invariant");
   end;

   Put_Line ("and the balance is untouched at" & Integer'Image (Balance_Of (A)));
end Show_Type_Invariants;
