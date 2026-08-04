with Ada.Command_Line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada_Check;
with Concatenation;

procedure Test_Concatenation is
   use Concatenation;

   function U (S : String) return Unbounded_String renames To_Unbounded_String;
begin
   Ada_Check.Suite ("Concatenation");

   --  The lab's own four cases.
   Ada_Check.Equal
     (Name     => "no trim, no whitespace",
      Actual   => Concat ((U ("Hello"), U (" World"), U ("!")), False, False),
      Expected => "Hello World!");

   Ada_Check.Equal
     (Name     => "trim, no whitespace",
      Actual   => Concat ((U (" This "), U (" _is_ "), U ("  a   "), U (" _check ")),
                          True, False),
      Expected => "This_is_a_check");

   Ada_Check.Equal
     (Name     => "trim and whitespace",
      Actual   => Concat ((U ("  This  "), U ("  is a  "), U ("  test.  ")), True, True),
      Expected => "This is a test.");

   Ada_Check.Equal
     (Name     => "one element gets no trailing whitespace",
      Actual   => Concat ((1 => U ("  Hi ")), True, True),
      Expected => "Hi");

   --  The Unbounded_String version is the one the String version is built on, so it is worth
   --  asking for directly.
   declare
      Joined : constant Unbounded_String :=
        Concat ((U ("a"), U ("b"), U ("c")), False, True);
   begin
      Ada_Check.Equal ("as an Unbounded_String", To_String (Joined), "a b c");
      Ada_Check.Equal ("with the length that implies", Length (Joined), 5);
   end;

   --  Nothing in, nothing out -- and no whitespace invented for an array with no gaps in it.
   declare
      Nothing : constant Unbounded_Strings (1 .. 0) := (1 .. 0 => Null_Unbounded_String);
   begin
      Ada_Check.Equal ("an empty array", Concat (Nothing, True, True), "");
   end;

   --  Trimming only removes the outside. "is a" keeps its inner space, which is the case that
   --  tells a real Trim from a "remove all spaces".
   Ada_Check.Equal
     (Name     => "inner spaces survive trimming",
      Actual   => Concat ((1 => U ("   is a   ")), True, False),
      Expected => "is a");

   --  An element that is entirely whitespace trims away to nothing, and the separator still goes
   --  in, because the separator is between positions rather than between characters.
   Ada_Check.Equal
     (Name     => "an element that trims to nothing",
      Actual   => Concat ((U ("one"), U ("    "), U ("two")), True, True),
      Expected => "one  two");

   --  Without trimming, what is there is what comes out.
   Ada_Check.Equal
     (Name     => "no trim leaves the padding alone",
      Actual   => Concat ((U (" a "), U (" b ")), False, False),
      Expected => " a  b ");

   Ada_Check.Finish;
   Ada.Command_Line.Set_Exit_Status
     (Ada.Command_Line.Exit_Status (Ada_Check.Failures));
end Test_Concatenation;
