with Ada.Command_Line;
with Ada_Check;
with C_Statistics;

procedure Test_C_Statistics is
   use C_Statistics;
begin
   Ada_Check.Suite ("C Statistics");

   Reset;

   --  Ada calling Ada, with C not involved.
   Ada_Check.Equal ("Mean on its own", Integer (Mean (4, 6)), 5);
   Ada_Check.Equal ("and it counted nothing", Integer (Call_Count), 0);

   --  Ada calls C, C calls Ada. One round trip, and the count proves C really ran.
   Ada_Check.Equal ("Summarise goes out to C and back", Integer (Summarise (4, 6)), 5);
   Ada_Check.Equal ("C incremented Ada's variable", Integer (Call_Count), 1);

   Ada_Check.Equal ("again", Integer (Summarise (10, 20)), 15);
   Ada_Check.Equal ("and again the count rose", Integer (Call_Count), 2);

   --  C calling C calling Ada, twice over. mean (2, 4) is 3, then mean (3, 12) is 7 -- not the
   --  mean of all three, which would be 6. Nesting a mean is not averaging.
   Reset;
   Ada_Check.Equal ("mean of the mean", Integer (Summarise_Three (2, 4, 12)), 7);
   Ada_Check.Equal ("which took two round trips", Integer (Call_Count), 2);

   --  Integer division truncates, in Ada as in C, so this is 3 rather than 3.5.
   Ada_Check.Equal ("odd sums truncate", Integer (Summarise (3, 4)), 3);

   Reset;
   Ada_Check.Equal ("Reset clears the count", Integer (Call_Count), 0);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_C_Statistics;
