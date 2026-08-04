package body Aggregate_Initialization is

   procedure Init (R : out Rec) is
   begin
      R := (X => 100, Y => 200, others => <>);
   end Init;

   procedure Init_Some (A : out Int_Arr) is
   begin
      A := (1 .. 5 => 99, others => 100);
   end Init_Some;

   procedure Init (A : out Int_Arr) is
   begin
      A := (others => 5);
   end Init;

end Aggregate_Initialization;
