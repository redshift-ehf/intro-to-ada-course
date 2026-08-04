with Ada.Command_Line;
with Ada_Check;
with Float_Average;

procedure Test_Float_Average is

   type Index is range 1 .. 100;

   type Float_Array is array (Index range <>) of Float;
   function Average_Of_Float is new Float_Average
     (T_Range => Index, T_Element => Float, T_Array => Float_Array);

   --  A second floating-point type, to show the generic does not care which one.
   type Precise is digits 12;
   type Precise_Array is array (Index range <>) of Precise;
   function Average_Of_Precise is new Float_Average
     (T_Range => Index, T_Element => Precise, T_Array => Precise_Array);

   Simple : constant Float_Array := (0.5, 0.7, 1.0, 1.0);
   Empty  : constant Float_Array (1 .. 0) := (others => 0.0);
   Fine   : constant Precise_Array := (0.1, 0.2, 0.3, 0.4, 1.6);
begin
   Ada_Check.Suite ("Average of Array of Float");

   Ada_Check.Equal ("0.5, 0.7, 1.0, 1.0", Average_Of_Float (Simple), 0.8);
   Ada_Check.Equal ("a single element",   Average_Of_Float ((1 => 4.25)), 4.25);

   --  Nothing to average, and it must not divide by zero.
   Ada_Check.Equal ("an empty array", Average_Of_Float (Empty), 0.0);

   --  The same generic over a type with twice the precision.
   Ada_Check.Equal ("0.1 .. 1.6 at twelve digits",
                    Float (Average_Of_Precise (Fine)), 0.52);

   --  Negative values average the way they should.
   Ada_Check.Equal ("-1.0, 1.0", Average_Of_Float ((-1.0, 1.0)), 0.0);
   Ada_Check.Equal ("-2.0, -4.0", Average_Of_Float ((-2.0, -4.0)), -3.0);

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Float_Average;
